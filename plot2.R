################# plot2.R ###################
## Exploratory Data Analysis: Course Project 2

################ Question 2 #################
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
## a plot answering this question.

## Set working directory if nessesary
setwd("/home/user/Dropbox/Coursera/Exploratory data analysis/Course Project 2")
## Load data from working directory
NEI <- readRDS("summarySCC_PM25.rds")

## Extract Baltimore fips, group by year and calculate total emissions for all groups
plot2 <- NEI[NEI$fips == "24510",] %>% group_by(year) %>% summarise(total = sum(Emissions))

## Open png device and specify name and dimensions
png("plot2.png", width=480, height=480)

## plot using base plotting system in R
p2 <- barplot(plot2$total, xlab="Year", names.arg=c("1999", "2002", "2005", "2008"), ylab="Total PM2.5 emissions (tons)", main="Total PM2.5 emissions for Baltimore City, Maryland"))

## Print plot
print(p2)

## Close device
dev.off()