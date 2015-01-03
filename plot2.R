


if(!exists("NEI")){
  RDS1<-"summarySCC_PM25.rds"
  RDS2<-"Source_Classification_Code.rds"
  if(!file.exists(RDS1)){
    FILE<-"exdata-data-NEI_data.zip"
    if(!file.exists(FILE)){
      URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
      download.file(url = URL, destfile = FILE, method = "curl")
    }
    unzip(FILE)
  }
  NEI <<- readRDS(RDS1)
  SCC <<- readRDS(RDS2)
}

NEI_baltimore<-NEI[NEI$fips==24510,]
totalbaltimoreperyear<-tapply(NEI_baltimore$Emissions, NEI_baltimore$year, FUN=sum)

main<-"PM2.5 emissions in Baltimore (24510)"
xlab<-"Year"
ylab<-"PM2.5 emissions (thousands of tons)"

png(filename = "plot2.png", width = 480, height = 480)
barplot(totalbaltimoreperyear / 1e3, ylab = ylab, main = main, xlab = xlab)
dev.off()
 