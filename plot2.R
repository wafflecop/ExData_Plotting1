plot2 <- function() {
  if(!file.exists("household_power_consumption.txt")) {
    url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    filename <- 'exdata%2Fdata%2Fhousehold_power_consumption.zip'
    download.file(url, filename, mode ='wb') 
    # extract files
    unzip(filename)
  }
  
  rows <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings ="?", skip = 66636, nrows = 2880, stringsAsFactors = TRUE)
  header <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings ="?", nrows = 1)
  colnames(rows) <- colnames(header)
  rows$DateTime <- as.POSIXct(paste(rows$Date, rows$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
  png(filename="plot2.png", width = 480, height = 480, bg = "transparent")
  plot(rows$DateTime, rows$Global_active_power, type="l", ylab ="Global Active Power (kilowatts)", xlab="")
  dev.off()
}