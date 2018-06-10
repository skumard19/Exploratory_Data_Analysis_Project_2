
## Reading data into R
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## total emissions from PM2.5 by year Baltimore City, Maryland (fips=="24510")
NEI.Baltimore <- NEI[NEI$fips=="24510",]
TotalEmissionsByYear <- aggregate(Emissions ~ year, NEI.Baltimore, sum)
png("plot2.png", width=480, height=480)
barplot(height=TotalEmissionsByYear$Emissions, 
        names.arg=TotalEmissionsByYear$year, 
        xlab="Year", 
        ylab=expression('Total PM'[2.5]*' Emissions'),
        main=expression('Total PM'[2.5]*' Emissions in Baltimore City, Maryland by Year')
       )
dev.off()
