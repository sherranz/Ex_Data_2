


FILE<-"exdata-data-NEI_data.zip"
if(!file.exists(FILE)){
  URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url = URL, destfile = FILE, method = "curl")
}
RDS1<-"summarySCC_PM25.rds"
RDS2<-"Source_Classification_Code.rds"
if(!file.exists(RDS1)){
  unzip(FILE)
}
#Caching data
if(!exists("NEI")){
  NEI <<- readRDS(RDS1)
  SCC <<- readRDS(RDS2)
}

NEI_baltimore<-NEI[NEI$fips==24510,]
totalbaltimoreperyear<-tapply(NEI_baltimore$Emissions, NEI_baltimore$year, FUN=sum) / 1e3

main<-"PM2.5 emissions in Baltimore (24510)"
xlab<-"Year"
ylab<-"PM2.5 emissions (thousands of tons)"

png(filename = "plot2.png", width = 480, height = 480)
theplot<-barplot(totalbaltimoreperyear, ylab = ylab, main = main, xlab = xlab)
lines(x=theplot[c(1,4)], y=totalbaltimoreperyear[c(1,4)], lwd = 3, col="blue")
dev.off()
 