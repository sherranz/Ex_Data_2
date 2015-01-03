require("ggplot2")
require("plyr")
if(!exists("NEI")){
  NEI <<- readRDS("summarySCC_PM25.rds")
  SCC <<- readRDS("Source_Classification_Code.rds")
}

NEI_baltimore<-NEI[NEI$fips==24510,]
data<-ddply(NEI_baltimore, c("year", "type"), function(x) colSums(x["Emissions"]))

png(filename = "plot3.png", width = 960, height = 480)
g<-ggplot(data, aes(year, Emissions))
print(g + geom_line()+facet_grid( . ~ type))
dev.off()
 