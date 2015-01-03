require("ggplot2")
require("plyr")

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
data<-ddply(NEI_baltimore, c("year", "type"), function(x) colSums(x["Emissions"]))

png(filename = "plot3.png", width = 960, height = 480)
g<-ggplot(data, aes(year, Emissions))
print(g + geom_line()+facet_grid( . ~ type))
dev.off()
 