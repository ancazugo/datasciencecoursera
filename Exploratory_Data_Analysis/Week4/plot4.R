#Set working directory
setwd('./Exploratory_Data_Analysis/Week4')

#Load packages
library(dplyr)
library(ggplot2)

#Load summarySCC_PM25 as data.frame
pm25 <- readRDS('summarySCC_PM25.rds')
source <- readRDS('Source_Classification_Code.rds')

#Delete a repeated variable
source$Data.Category <- NULL

#Merge the two dataFrames by SCC
merged <- merge(pm25, source, by = 'SCC')

#Filter if short.name contains coal in its value
coalRelated <- merged[grep('[Cc][Oo][Aa][Ll]', merged$Short.Name),]

#Summarise by year SCC.Level.One and type
coalMean <- coalRelated %>%
    group_by(year, SCC.Level.One, type) %>%
    summarise(MeanEmissions = mean(Emissions, na.rm = T))

#Barplot with facet_grid SCC.Level.One and color by type of coal related emissions
#Notice the scale, some values are too small so sqaured values were better
ggplot(coalMean) + geom_bar(stat = 'identity', aes(x = factor(year), y = sqrt(MeanEmissions), fill = type)) +
    scale_y_continuous(breaks = seq(0, 22, 2)) +
    labs(x = 'Year', y = expression('Squared Mean PM'[2.5]* ' Emissions (tons)'), fill = 'Type', 
         title = expression('Squared Mean PM'[2.5]* ' Emissions by Year for Every Type of Source Related to Coal in the US')) +
    facet_grid(cols = vars(SCC.Level.One), labeller = label_wrap_gen(width = 20)) +
    theme_bw() + theme(legend.title = element_text(face = 'bold'), panel.grid = element_blank())

#Save ggplot as png
ggsave('plot4.png')

#Close graphics device
dev.off()