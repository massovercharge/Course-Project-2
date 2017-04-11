################# plot6.R ###################
## Exploratory Data Analysis: Course Project 2

################ Question 6 #################
## Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in Los Angeles County, California 
## (fips == "06037"). Which city has seen greater changes over time in motor 
## vehicle emissions?

## Set working directory if nessesary
setwd("/home/user/Dropbox/Coursera/Exploratory data analysis/Course Project 2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## load package required for data manipulation
library(dplyr)

## Extract SCC values where  SCC.Level.Two string contains "vehicle" and save to variable
vehicle <- subset(SCC, grepl("vehicle", SCC.Level.Two, ignore.case = TRUE))$SCC

## Extract rows from NEI where SCC value is related to vehicle
plot6 <- NEI[which(NEI$SCC %in% vehicle),]
## Extract data for Baltimore and Los Angeles
plot6 <- plot6[plot6$fips=="24510"|plot6$fips=="06037",]
## Group contents of plot4 by year and calculate total emissions for all groups
plot6 <- plot6 %>% group_by(year, fips) %>% summarise(total = sum(Emissions))
## Group by location and calculate percent change in total emissions from 
## vehicles (relative to 1999)
plot6 <- plot6 %>% group_by(fips) %>% mutate(change = (total/total[1]-1)*100)

## Make city column
plot6$city <- rep(NA, nrow(plot6))
## Add names of cities corresponding to fips to city column
plot6[plot6$fips == "06037", ]$city <- "Los Angles County"
plot6[plot6$fips == "24510", ]$city <- "Baltimore City"

## Load package required for plot generation
library(ggplot2)

## Open png device and specify name and dimensions
png('plot6.png', width=480*2, height=480)

## Generate plots using ggplot2 and save to variable
total <- ggplot(data=plot6, aes(x=year,y=total, colour = city, fill = city)) + 
  ## Use bar type plot
  geom_bar(stat = "identity") + 
  ## Use the years for x-axis marks
  scale_x_discrete(limit = unique(plot6$year)) + 
  ## Define axis and plot title
  labs(title = "Total PM2.5 emissions \nfrom motor vehicles in \nBaltimore City & Los Angeles County", x = "Year", y = "Total PM2.5 emissions (tons)") + 
  ## Make a separate plot for each type
  facet_wrap(facets = ~city, nrow = 1) + 
  ## Center title text
  theme(plot.title = element_text(hjust = 0.5))

## Generate plots using ggplot2 and save to variable
change <- ggplot(data=plot6, aes(x=year,y=change, colour = city)) + 
  ## Use line plot
  geom_line() + 
  ## Use the years for x-axis marks
  scale_x_discrete(limit = unique(plot6$year)) + 
  ## Define axis and plot title
  labs(title = "Percentage change in PM2.5 \nemissions from motor vehicles in \nBaltimore City & Los Angeles County \n(relative to 1999)", x = "Year", y = "Change in PM2.5 emissions (%)") + 
  ## Center title text
  theme(plot.title = element_text(hjust = 0.5))

## Load package required for multiple plots in same print
library(gridExtra)
## Print plots in 2 columns
print(grid.arrange(total, change, ncol=2))

## Close device
dev.off()