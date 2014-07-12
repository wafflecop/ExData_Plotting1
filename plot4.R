plot4 <- function() {
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
  png(filename="plot4.png", width = 480, height = 480, bg = "transparent")
  par(mfcol=c(2,2), mar = c(4,4,1,1), oma = c(2,2,2,2))
  with(rows, {
    plot(rows$DateTime, rows$Global_active_power, type="l", ylab ="Global Active Power", xlab="")
    plot(rows$DateTime, rows$Sub_metering_1, type="l", ylab ="Energy sub metering", xlab="")
    lines(rows$DateTime, rows$Sub_metering_2, col="red")
    lines(rows$DateTime, rows$Sub_metering_3, col="blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(2,2,2), col=c("black", "red", "blue"))
    plot(rows$DateTime, rows$Voltage, type="l", ylab ="Voltage", xlab="datetime")
    plot(rows$DateTime, rows$Global_reactive_power, type="l", ylab ="Global_reactive_power", xlab="datetime")
  })  
  dev.off()
}