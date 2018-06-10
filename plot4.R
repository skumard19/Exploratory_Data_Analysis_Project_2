
## Reading data into R
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge both data sets
NEI.SCC <- merge(NEI, SCC, by = "SCC")

## Emissions from coal combustion-related sources 
CoalSources <- grepl("coal", NEI.SCC$Short.Name, ignore.case=TRUE)
NEI.SCC.Coal <- NEI.SCC[CoalSources, ]

CoalEmissionsByYear <- aggregate(Emissions ~ year, NEI.SCC.Coal, sum)

library(ggplot2)

png("plot4.png", width=640, height=480)

g <- ggplot(CoalEmissionsByYear, aes(factor(year), Emissions))

g + geom_bar(stat="identity") +
    xlab("Year") +
    ylab(expression('Total PM'[2.5]*' Emissions')) +
    ggtitle(expression('Total PM'[2.5]*' Emissions from Coal Sources'))

dev.off()
