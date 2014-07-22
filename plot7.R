plot7 <- function() {
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
  NEI$type = as.factor(NEI$type)
  
  Baltimore = NEI[NEI$fips == "24510",]
  z = aggregate(Baltimore$Emissions ~ Baltimore$year + Baltimore$type, FUN=sum)
  colnames(z) = c('Year' ,'type', 'Emissions')
  g = ggplot(z, aes(Year, Emissions))
  png(filename="plot7.png", width = 640, height = 480, bg = "transparent")
  g + geom_point(size = 4) + facet_grid(.~type) + labs(title = "Baltimore City")
  dev.off()
}