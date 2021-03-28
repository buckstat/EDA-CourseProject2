#Plot 5 
library(tidyverse)
library(dplyr)

#Read Data in
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#pull out Baltimore City and Los Angeles Data
ab <- subset(NEI, fips=="24510" & type=="ON-ROAD")

#Compute total Emissions by year
sby <- aggregate(x = ab$Emissions,                           # Specify data column
                 by = list(ab$year),                         # Specify group indicator
                 FUN = sum)


# convert to character for graphing
sby$Group.1 <- as.character(sby$Group.1)

#Print out the appropriate graph
png("plot5.png", width=640, height=480)
ggplot(sby,                                                  # Grouped barplot using ggplot2
       aes(x = Group.1,
           y = x, fill = Group.1)) +
  geom_bar(stat = "identity", show.legend = FALSE,
           position = "dodge", col = "black") +
  labs(title = "PM2.5 Emissions from Motor Vehicles for Baltimore City", x = "by Year", y = "PM2.5 Emissions in Tons") +
  theme_grey(base_size = 14)
  dev.off()