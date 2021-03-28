#Plot 1   Emissions from all sources by year
library(tidyverse)
library(dplyr)

#Read in Files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Compute sby = Sum of emissions by year, divide by 1,000,000 to help with scaling
sby <- tapply(NEI$Emissions, NEI$year, sum)
sbyM <- sby/1000000

#Plot a bar graph, since the data is in 3 year intervals
png("plot1.png", width=640, height=480)

barplot(sbyM, col = "blue", main = "Total Emissions of PM2.5 from all sources ",
        ylab = "Total Emissions (Millions of tons)", xlab  = "Year Recorded")

dev.off()



