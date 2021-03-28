library(tidyverse)
library(dplyr)

#Read in the files, pull out the Baltimore City Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
BCNEI <- NEI[NEI$fips %in% c("24510") ,]


#Compute the total Emissions by year and type, store in variable a
a <- aggregate(x = BCNEI$Emissions,                      # Specify data column
          by = list(BCNEI$year,BCNEI$type),              # Specify group indicator
          FUN = sum)                                     # Specify function (i.e. sum)

#Plot the appropriate Bar Graphs, keep the scaling for each type
png("plot3.png", width=640, height=480)

a$Group.1<- as.character(a$Group.1)
ggplot(a, aes(x=Group.1,y=x, fill=Group.2)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~Group.2, scales="free_y")  +
  labs(title = "PM2.5 Emissions Baltimore City", x = "by Source Type", y = "Emissions in Tons") +                                                 
  theme_grey(base_size = 14)
dev.off()
