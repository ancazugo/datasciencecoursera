#Set working directory
setwd('./Exploratory_Data_Analysis/Week1')

#Read the file while zipped
df <- read.delim(unz('exdata_data_household_power_consumption.zip', 'household_power_consumption.txt'), 
                 sep = ';', header = T, na.strings = '?')

#Subset according to dates
df_2 <- subset(df, df$Date == '1/2/2007' | df$Date == '2/2/2007')
#Transform dates to correct format
df_2$Date <- as.Date(df_2$Date, format="%d/%m/%Y")

#Create png device as 480x480 px
png('plot1.png', width = 480, height = 480)

#Create histogram
hist(df_2$Global_active_power, col = '#FF2500', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')
#Close graphics device
dev.off()
