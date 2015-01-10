require("ggplot2")
require("plyr")

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
data<-ddply(NEI_baltimore, c("year", "type"), function(x) colSums(x["Emissions"]))

px<-ddply(data, "type", function(x) c(p1=x$Emissions[1], p4=x$Emissions[4]))
data_line<-merge(data, px, by = "type")
data_line$lx<-with(data_line, p1 + (year - 1999) * (p4 - p1) / 9)

png(filename = "plot3.png", width = 960, height = 480)
plot<-ggplot(data, aes(year, Emissions))
bar<-geom_bar(stat="identity", col="darkgray", fill="lightgray")
facet<-facet_grid( . ~ type)
line<-geom_line(data=data_line, aes(year, lx), col="blue")
scale<- scale_x_continuous(breaks=c(1999, 2002, 2005, 2008))
print(plot + bar + facet + line + scale)

dev.off()
 