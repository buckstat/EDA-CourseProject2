#Plot 4 Emissions from Fuel Combustion across the U.S. by Year
library(tidyverse)
library(dplyr)

#Read in the Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Merge the data with the descriptions, by SCC
mdata <- merge(NEI, SCC, by="SCC")

#length(grep("[Cc]oal",SCC$Short.Name))                     #  Calculate number of records for my own benefit
#length(grep("Coal",SCC$EI.Sector))                         #  Check out the EI.Sector variable too

#Pull out the records with Coal in them using the Short.Name variable
#this variable seemed the most appropriate, it seemed to capture more of the Coal Combustion data


b <- grepl("Coal",mdata$Short.Name)
ab <- mdata[b,]

#Compute the Emissions amount by Year
sby <- aggregate(x = ab$Emissions,                           # Specify data column
                 by = list(ab$year),                         # Specify group indicator
                 FUN = sum)

# Divide total to help with scaling the graph- make year a character vector for graphing
sby$x <- sby$x/100000
sby$Group.1 <- as.character(sby$Group.1)


#Plot the appropriate Bar Graphs, keep the scaling for each type
png("plot4.png", width=640, height=480)
ggplot(sby,                                      # Grouped barplot using ggplot2
       aes(x = Group.1,
           y = x, fill = Group.1)) +
  geom_bar(stat = "identity", show.legend = FALSE,
           position = "dodge", col = "black") +
           labs(title = "PM2.5 Emissions from Fuel Combustion", x = "by Year", y = "Emissions in (100,000)Tons") +
           theme_grey(base_size = 14)
dev.off()
