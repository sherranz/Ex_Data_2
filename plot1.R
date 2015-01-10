


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


totalperyear<-tapply(NEI$Emissions, NEI$year, FUN=sum) / 1e6

main<-"Total U.S. PM2.5 emissions"
xlab<-"Year"
ylab<-"PM2.5 emissions (millions of tons)"

png(filename = "plot1.png", width = 480, height = 480)
theplot<-barplot(totalperyear, ylab = ylab, xlab = xlab, main = main)
lines(x=theplot[c(1,4)], y=totalperyear[c(1,4)], lwd = 3, col="blue")
dev.off()
 