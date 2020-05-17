#Set working directory
setwd('./Exploratory_Data_Analysis/Week4')

#Load packages
library(dplyr)
library(ggplot2)

#Load summarySCC_PM25 as data.frame
pm25 <- readRDS('summarySCC_PM25.rds')

#Build a new data.frame summarising the emissions by year by type
typeByYear <- pm25 %>%
    filter(fips == '24510') %>%
    select(year, Emissions, type) %>%
    group_by(year, type) %>%
    summarise(TotalEmissions = sum(Emissions, na.rm = T))

#Barplot with one facet per type 
ggplot(typeByYear) + geom_bar(stat = 'identity', aes(x = factor(year), y = TotalEmissions, fill = type), size = 1) +
    labs(x = 'Year', y = expression('Total PM'[2.5]* ' Emissions (tons)'), fill = 'Type', 
         title = expression('Total PM'[2.5]* ' Emissions by Year for Every Type of Source in the US')) + 
    theme_light() + theme(legend.title = element_text(face = 'bold'), panel.grid = element_blank()) + facet_grid(~type)

#Save ggplot as png
ggsave('plot3.png')

#Close graphics device
dev.off()