################# plot1.R ###################
## Exploratory Data Analysis: Course Project 2

################ Question 1 #################
## Have total emissions from PM2.5 decreased in the United States from 
## 1999 to 2008? Using the base plotting system, make a plot showing the 
## total PM2.5 emission from all sources for each of the years 1999, 
## 2002, 2005, and 2008.

## Set working directory if nessesary
setwd("/home/user/Dropbox/Coursera/Exploratory data analysis/Course Project 2")
## Load data from working directory
NEI <- readRDS("summarySCC_PM25.rds")

## load package required for data manipulation
library(dplyr)

## select required columns from NEI, group by year and calculate 
## total emissions per year
plot1 <- NEI %>% select(year, type, Emissions) %>% group_by(year) %>% summarise(total = sum(Emissions))

## Open png device and specify name and dimensions
png("plot1.png", width=480, height=480)

## plot using base plotting system in R
p1 <- barplot(plot1$total, names.arg=c("1999", "2002", "2005", "2008"), xlab="Year", ylab="Total PM2.5 emissions (tons)", main="Total PM2.5 emissions in the US"))

## Print plot
print(p1)

## Close device
dev.off()