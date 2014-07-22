plot10 <- function() {
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
  compareVeh = NEI[(NEI$fips == "24510" | NEI$fips == "06037" ) & NEI$SCC %in% motorVehicle$SCC,]
  v = aggregate(compareVeh$Emissions ~ compareVeh$year + compareVeh$fips, FUN=sum)
  colnames(v) = c("Year", "City", "Emissions")
  v$City = as.factor(v$City)
  v$City = factor(v$City, labels=c(" Los Angeles County","Baltimore City"))
  png(filename="plot10.png", width = 480, height = 480, bg = "transparent")
  g = ggplot(v, aes(Year, Emissions))
  g + geom_point(size = 4)+ labs(title = "Los Angeles County vs Baltimore City", y="Motor Vehicle Emissions") + facet_grid(.~City)
  dev.off()
}