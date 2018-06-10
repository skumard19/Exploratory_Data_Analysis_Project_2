
## Reading data into R
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

## total emissions from PM2.5 by year Baltimore City, Maryland (fips=="24510")
NEI.Baltimore <- NEI[NEI$fips=="24510",]

TotalEmissionsByYearType <- aggregate(Emissions ~ year + type, NEI.Baltimore, sum)

png("plot3.png", width=640, height=480)

g <- ggplot(TotalEmissionsByYearType, aes(year, Emissions, color = type))

g + geom_line() + 
    xlab("Year") + 
    ylab(expression('Total PM'[2.5]*' Emissions')) + 
    ggtitle(expression('Total PM'[2.5]*' Emissions in Baltimore City, Maryland by Year and Source'))

dev.off()
