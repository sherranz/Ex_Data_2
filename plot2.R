if(!exists("NEI")){
  NEI <<- readRDS("summarySCC_PM25.rds")
  SCC <<- readRDS("Source_Classification_Code.rds")
}

NEI_baltimore<-NEI[NEI$fips==24510,]
totalbaltimoreperyear<-tapply(NEI_baltimore$Emissions, NEI_baltimore$year, FUN=sum)

main<-"PM2.5 emissions in Baltimore (24510)"
xlab<-"Year"
ylab<-"PM2.5 emissions (thousands of tons)"

png(filename = "plot2.png", width = 480, height = 480)
barplot(totalbaltimoreperyear / 1e3, ylab = ylab, main = main, xlab = xlab)
dev.off()
 