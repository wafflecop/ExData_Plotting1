plot9 <- function() {
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
  motorVehicle = SCC[grep("Veh", SCC$Short.Name),]
  motorVehicle = motorVehicle[grep("Onroad|Nonroad", motorVehicle$Data.Category) ,]
  BaltimoreVeh = NEI[NEI$fips == "24510" & NEI$SCC %in% motorVehicle$SCC,]
  v = aggregate(BaltimoreVeh$Emissions ~ BaltimoreVeh$year + BaltimoreVeh$type, FUN=sum)
  colnames(v) = c("Year", "Type", "Emissions")
  png(filename="plot9.png", width = 480, height = 480, bg = "transparent")
  g = ggplot(v, aes(Year, Emissions))
  g + geom_point(size = 4)+ labs(title = "Baltimore City", y="Motor Vehicle Emissions")
  dev.off()
}