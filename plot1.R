if(!exists("NEI")){
  NEI <<- readRDS("summarySCC_PM25.rds")
  SCC <<- readRDS("Source_Classification_Code.rds")
}


totalperyear<-tapply(NEI$Emissions, NEI$year, FUN=sum)

main<-"Total U.S. PM2.5 emissions"
xlab<-"Year"
ylab<-"PM2.5 emissions (millions of tons)"

png(filename = "plot1.png", width = 480, height = 480)
barplot(totalperyear / 1e6, ylab = ylab, xlab = xlab, main = main)
dev.off()
 