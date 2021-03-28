#Plot 2 Emissions from all sources for Baltimore City by year
library(tidyverse)

#Read in Dat
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# pull out data for Baltimore City
BCNEI <- NEI[NEI$fips %in% c("24510") ,]


#Compute sby = Sum of emissions by year
sby <- tapply(BCNEI$Emissions, BCNEI$year, sum)






# Create and print the appropriate Bar Graph
png("plot2.png", width=640, height=480)

barplot(sby, col = "blue", main = "Emissions of PM2.5 for Baltimore City from all sources",
        ylab = "Total Emissions (tons)", xlab  = "Year Recorded")

dev.off()
