


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


totalperyear<-tapply(NEI$Emissions, NEI$year, FUN=sum)

main<-"Total U.S. PM2.5 emissions"
xlab<-"Year"
ylab<-"PM2.5 emissions (millions of tons)"

png(filename = "plot1.png", width = 480, height = 480)
barplot(totalperyear / 1e6, ylab = ylab, xlab = xlab, main = main)
dev.off()
 