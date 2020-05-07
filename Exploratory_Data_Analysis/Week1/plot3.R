#Set working directory
setwd('./Exploratory_Data_Analysis/Week1')

#Read the file while zipped
df <- read.delim(unz('exdata_data_household_power_consumption.zip', 'household_power_consumption.txt'), 
                 sep = ';', header = T, na.strings = '?')

#Subset according to dates
df_2 <- subset(df, df$Date == '1/2/2007' | df$Date == '2/2/2007')
#Transform dates to correct format
df_2$Date <- as.Date(df_2$Date, format="%d/%m/%Y")
#Transform time to correct format
df_2$Time <- format(strptime(df_2$Time, format = "%H:%M:%S"), '%H:%M:%S')
#Create new column with date and time in order to find weekdays
df_2$Date.Time <- as.POSIXct(paste(df_2$Date, df_2$Time), format = '%Y-%m-%d %H:%M:%S')

#Create png device as 480x480 px
png('plot3.png', width = 480, height = 480)

#Create plot based on column with largest values
plot(Sub_metering_1 ~ Date.Time, data = df_2, type = 'l', ylab = 'Energy sub metering')
#Add the other columns as lines
lines(df_2$Date.Time, df_2$Sub_metering_2, col = 'blue')
lines(df_2$Date.Time, df_2$Sub_metering_3, col = 'red')
#Add legend at topright
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'blue', 'red'), lwd = 1)
#Close graphics device
dev.off()