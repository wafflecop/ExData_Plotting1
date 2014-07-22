plot8 <- function() {
  #install.packages('ggplot2')
  #library('ggplot2')
  if(!file.exists("summarySCC_PM25.rds")) {
    url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
    filename <- 'exdata%2Fdata%2FNEI_data.zip'
    download.file(url, filename, mode ='wb') 
    # extract files
    unzip(filename)
  }
  
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  NEI$year = as.factor(NEI$year)
  coalComb = SCC[grep("Comb.*[c|C]oal", SCC$Short.Name),]
  Coal = NEI[NEI$SCC %in% coalComb$SCC,]
  c = aggregate(Coal$Emissions, by=list(Category=Coal$year), FUN=sum)
  colnames(c) = c("Year", "Emissions")
  png(filename="plot8.png", width = 480, height = 480, bg = "transparent")
  g = ggplot(c, aes(Year, Emissions))
  g + geom_point(size = 4)+ labs(title = "United States", y="Coal Combustion Emissions")
  dev.off()
}