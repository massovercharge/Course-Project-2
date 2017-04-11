################# plot3.R ###################
## Exploratory Data Analysis: Course Project 2

################ Question 3 #################
## Of the four types of sources indicated by the type (point, nonpoint, 
## onroad, nonroad) variable, which of these four sources have seen decreases 
## in emissions from 1999–2008 for Baltimore City? Which have seen increases in 
## emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
## answer this question.

## Set working directory if nessesary
setwd("/home/user/Dropbox/Coursera/Exploratory data analysis/Course Project 2")
## Load data from working directory
NEI <- readRDS("summarySCC_PM25.rds")

## load package required for data manipulation
library(dplyr)

## Extract data for Baltimore, group by year and type, calculate total emissions for all groups
plot3 <- subset(NEI, fips == "24510") %>% group_by(year, type) %>% summarise(total = sum(Emissions))

## Open png device and specify name and dimensions
png("plot3.png", width=480, height=480)

## Load package required for plot generation
library(ggplot2)

## Generate plot using ggplots2
p3 <- ggplot(data=plot3, 
             aes(x=year,y=total,color=type, fill=type)) + 
  ## Use bar plot
  geom_bar(stat = "identity") + 
  ## Use the years for x-axis marks
  scale_x_discrete(limit = unique(plot3$year)) + 
  ## Define axis and plot title
  labs(title = "Total PM2.5 emissions by source type for Baltimore City, Maryland", x = "Year", y = "Total PM2.5 emissions (tons)")
  ## Make a separate plot for each type
  facet_wrap(facets = ~type, nrow = 1) +  
  
## Print plot
print(p3)

## Close device
dev.off()
