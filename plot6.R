#Plot 6  Compare Baltimore City with Los Angeles
library(dplyr)
library(tidyverse)

#Read in Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset for each city
bc <- subset(NEI, fips=="24510" & type=="ON-ROAD")
la <- subset(NEI, fips=="06037" & type=="ON-ROAD")

#Compute Emissions totals for Baltimore City
sby1 <- aggregate(x = bc$Emissions,                           # Specify data column
                 by = list(bc$year),                         # Specify group indicator
                 FUN = sum)
#Compute Emissions totals for Los Angeles
sby2 <- aggregate(x = la$Emissions,                           # Specify data column
                 by = list(la$year),                         # Specify group indicator
                 FUN = sum)

#Create a factor variable for the 2 cities and combine the data into 1 dataframe
sby1$Group.2 <- as.factor(c(rep("Baltimore City", times = 4)))
sby2$Group.2 <- as.factor(c(rep("Los Angeles", times = 4)))
a <- rbind(sby1,sby2)



#Plot the appropriate Bar Graphs, keep the scaling for each City, easier to see % change
png("plot6.png", width=640, height=480)
a$Group.1<- as.character(a$Group.1)
ggplot(a, aes(x=Group.1,y=x, fill=Group.2)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~Group.2, scales="free_y")  +
  labs(title = "PM2.5 Vehicle Emission Comparison between Baltimore City and Los Angeles", x = "by City and Year", y = "Emissions in Tons")  +  
  theme_grey(base_size = 14)
dev.off()