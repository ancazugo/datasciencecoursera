#Set working directory
setwd('./Exploratory_Data_Analysis/Week4')

#Load packages
library(dplyr)

#Load summarySCC_PM25 as data.frame
pm25 <- readRDS('summarySCC_PM25.rds')
sourceClassification <- readRDS('Source_Classification_Code.rds')

#Build a new data.frame summarising the emissions by year for Baltimore
baltimoreByYear <- pm25 %>%
    filter(fips == '24510') %>%
    select(year, Emissions) %>%
    group_by(year) %>%
    summarise(TotalEmissions = sum(Emissions, na.rm = T))

#Create png device as 480x480 px
png('plot2.png', width = 480, height = 480)

#Line chart with the base system
plot(TotalEmissions ~ year, data = baltimoreByYear, type = 'l', col = 'red', lwd = 3, xlab = 'Year',
     ylab = expression('Total PM'[2.5]* ' Emissions (tons)'), 
     main = expression('Total PM'[2.5]* ' Emissions by Year in Baltimore, MD'), xaxt = 'n')
axis(side = 1, at = c(1999, 2002, 2005, 2008))

#Close graphics device
dev.off()