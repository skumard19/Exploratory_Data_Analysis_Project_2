
## Reading data into R
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge both data sets
NEI.SCC <- merge(NEI, SCC, by = "SCC")

## Emissions from motor vehicle sources in Baltimore, Maryland
NEI.SCC.Baltimore.Motor <- NEI.SCC[NEI.SCC$fips=="24510" & NEI.SCC$type=="ON-ROAD",  ]
MotorEmissionsByYear <- aggregate(Emissions ~ year, NEI.SCC.Baltimore.Motor, sum)

library(ggplot2)

png("plot5.png", width=840, height=480)

g <- ggplot(MotorEmissionsByYear, aes(factor(year), Emissions))

g + geom_bar(stat="identity") +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*' Emissions')) +
  ggtitle(expression('Total PM'[2.5]*' Emissions from Motor Vehicles (Type = On-Road) in Baltimore City, Maryland'))

dev.off()
