
## Reading data into R
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge both data sets
NEI.SCC <- merge(NEI, SCC, by = "SCC")

## Emissions from motor vehicle sources in Baltimore, Maryland
NEI.SCC.Baltimore.LA.Motor <- NEI.SCC[(NEI.SCC$fips=="24510"|NEI.SCC$fips=="06037") & NEI.SCC$type=="ON-ROAD",  ]
MotorEmissionsByYearCity <- aggregate(Emissions ~ year + fips, NEI.SCC.Baltimore.LA.Motor, sum)
MotorEmissionsByYearCity$fips[MotorEmissionsByYearCity$fips=="24510"] <- "Baltimore, MD"
MotorEmissionsByYearCity$fips[MotorEmissionsByYearCity$fips=="06037"] <- "Los Angeles, CA"

library(ggplot2)

png("plot6.png", width=1040, height=480)

g <- ggplot(MotorEmissionsByYearCity, aes(factor(year), Emissions))

g + facet_grid(. ~ fips) + 
  geom_bar(stat="identity")  +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*' Emissions')) +
  ggtitle(expression('Total PM'[2.5]*' Emissions from Motor Vehicles (Type = On-Road) in Baltimore City, Maryland Vs Los Angeles County, California'))

dev.off()
