plot5 <- function() {
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
  
  y = aggregate(NEI$Emissions, by=list(Category=NEI$year), FUN=sum)
  png(filename="plot5.png", width = 480, height = 480, bg = "transparent")
  plot(y, ylab="Pollution Levels", xlab="United States")
  yr = nrow(y)
  segments(1, y[1,2], x1=yr, y1=y[yr,2], col = "red", lwd=2)
  dev.off()
}