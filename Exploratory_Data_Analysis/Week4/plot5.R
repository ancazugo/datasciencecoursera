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

#Create png device as 480x480 px
png('plot5.png', width = 500, height = 500)

#Boxplot with panels for SCC.Level.One motor vehicle related square root emissions
#Notice the scales of the panels
bwplot(sqrt(Emissions) ~ factor(year) | SCC.Level.One, motorRelated,
       xlab = 'Year', ylab = expression('Squared PM'[2.5]* ' Emissions (tons)'),
       main = expression('Squared PM'[2.5]*' Emissions by Year Related to Motor Vehicle in the US'),
       col = 'red', layout = c(1,2), scales = list(y = list(relation = "free")))

#Close graphics device
dev.off()