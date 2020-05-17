#Set working directory
setwd('./Exploratory_Data_Analysis/Week4')

#Load packages
library(lattice)

#Load summarySCC_PM25 as data.frame
pm25 <- readRDS('summarySCC_PM25.rds')
source <- readRDS('Source_Classification_Code.rds')

#Delete a repeated variable
source$Data.Category <- NULL

#Merge the two dataFrames by SCC
merged <- merge(pm25, source, by = 'SCC')

#Filter if short.name contains motor vehicle in its value
motorRelated <- merged[grep('motor vehicle', tolower(merged$Short.Name)),]

#Filter if fips corresponds to the values of Baltimore and Los Angeles
motorRelatedCities <- motorRelated[motorRelated$fips %in% c('06037', '24510'),]

#Change fips to cities names
motorRelatedCities$fips <- gsub('06037', 'Baltimore', motorRelatedCities$fips)
motorRelatedCities$fips <- gsub('24510', 'Los Angeles', motorRelatedCities$fips)

#Create png device as 480x480 px
png('plot6.png', width = 550, height = 500)

#Barchart for motor vehicle related emissions in Baltimore and Los Angeles
barchart(Emissions ~ factor(year), motorRelatedCities, group = fips, auto.key = list(space = 'bottom', columns = 2),
       xlab = 'Year', ylab = expression('PM'[2.5]* ' Emissions (tons)'),
       main = expression('PM'[2.5]*' Emissions by Year Related to Motor Vehicle in Baltimore and Los Angeles'))

#Close graphics device
dev.off()