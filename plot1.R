plot1 <- function() {
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
  rows$Date <- as.Date(rows$Date, format = "%d/%m/%Y")
  png(filename="plot1.png", width = 480, height = 480, bg = "transparent")
  hist(rows$Global_active_power, col="red", xlab ="Global Active Power (kilowatts)", main = "Global Active Power")
  dev.off()
}