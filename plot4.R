################# plot4.R ###################
## Exploratory Data Analysis: Course Project 2

################ Question 4 #################
# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?

## Set working directory if nessesary
setwd("/home/user/Dropbox/Coursera/Exploratory data analysis/Course Project 2")
## Load data from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## load package required for data manipulation
library(dplyr)

## Extract SCC values where EI.Sector string contains "coal" and save to variable
coal <- subset(SCC, grepl("coal", EI.Sector, ignore.case = TRUE))$SCC

## Extract rows from NEI where SCC value is related to coal
plot4 <- NEI[which(NEI$SCC %in% coal),]
## Group contents of plot4 by year and calculate total emissions for all groups
plot4 <- plot4 %>% group_by(year) %>% summarise(total = sum(Emissions))

## Open png device and specify name and dimensions
png("plot4.png", width=480, height=480)

## Generate plot using ggplot2
p4 <- ggplot(data=plot4, aes(x=year,y=total)) + 
  ## Use bar plot
  geom_bar(stat = "identity") + 
  ## Use the years for x-axis marks
  scale_x_discrete(limit = unique(plot3$year)) + 
  ## Define axis and plot title
  labs(title = "Total PM2.5 emissions from coal in the US", x = "Year", y = "Total PM2.5 emissions (tons)")

## Print plot
print(p4)

## Close device
dev.off()