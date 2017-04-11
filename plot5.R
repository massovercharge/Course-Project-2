################# plot5.R ###################
## Exploratory Data Analysis: Course Project 2

################ Question 5 #################
## How have emissions from motor vehicle sources changed from 1999–2008 
## in Baltimore City?

## Set working directory if nessesary
setwd("/home/user/Dropbox/Coursera/Exploratory data analysis/Course Project 2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## load package required for data manipulation
library(dplyr)

## Extract SCC values where  SCC.Level.Two string contains "vehicle" and save to variable
vehicle <- subset(SCC, grepl("vehicle", SCC.Level.Two, ignore.case = TRUE))$SCC

## Extract rows from NEI where SCC value is related to vehicle
plot5 <- NEI[which(NEI$SCC %in% vehicle),]
## Extract data for Baltimore, group contents of plot4 by year and calculate total emissions for all groups
plot5 <- plot5[plot5$fips=="24510",] %>% group_by(year) %>% summarise(total = sum(Emissions))

## Load package required for plot generation
library(ggplot2)

## Open png device and specify name and dimensions
png("plot5.png", width=480, height=480)

## Generate plot using ggplot2
p5 <- ggplot(data=plot5, aes(x=year,y=total)) + 
  ## Use bar plot
  geom_bar(stat = "identity") + 
  ## Use the years for x-axis marks
  scale_x_discrete(limit = unique(plot5$year)) + 
  ## Define axis and plot title
  labs(title = "Total PM2.5 emissions from motor vehicles in Baltimore City, Maryland", x = "Year", y = "Total PM2.5 emissions (tons)")

## Print plot
print(p5)

## Close device
dev.off()
