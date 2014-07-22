plot6 <- function() {
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
  
  Baltimore = NEI[NEI$fips == "24510",]
  y = aggregate(Baltimore$Emissions, by=list(Category=Baltimore$year), FUN=sum)
  png(filename="plot6.png", width = 480, height = 480, bg = "transparent")
  plot(y, ylab="Pollution Levels", xlab="Baltimore City")
  dev.off()
}