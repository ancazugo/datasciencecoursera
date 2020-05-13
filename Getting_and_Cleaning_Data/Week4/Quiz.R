setwd('./Getting_and_Cleaning_Data/Week4')
library(quantmod)
library(lubridate)

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = 'Idaho.csv')
idaho <- read.delim('Idaho.csv', sep = ',')

#Split wgtp on colnames and find 123rd value on the list
strsplit(names(idaho), split = '^wgtp')[[123]]

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', destfile = 'gdp.csv')
gdp <- read.delim('gdp.csv', sep = ',', skip = 4, na.strings = c('', '..'))
gdp <- gdp[1:231, c('X', 'X.1', 'X.3', 'X.4')]
colnames(gdp) <- c('CountryCode', 'Ranking', 'CountryName', 'GDP')

#Remove incomplete rows
gdp <- gdp[complete.cases(gdp),]

#Remove commas from numbers, convert to int and get the mean
gdp$GDP <- as.integer(gsub(',', '', gdp$GDP))
meanGDP <- mean(gdp$GDP)
meanGDP

#Count the number of countries that start with United
gdp[grep('United', gdp$CountryName),]

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', destfile = 'education.csv')
education <- read.csv('education.csv', header = T, na.strings = c('NA', ''))

#Merge education and gdp datasets according to CountryCode
df <- merge(gdp, education, by = 'CountryCode', all = T)

#Find 'Fiscal year end: June' on Special Notes column and show rows
fiscalJune <- grep('Fiscal year end: June', df$Special.Notes)
df[fiscalJune ,]

#Load Amazon stock values and dates
amzn <- getSymbols('AMZN', auto.assign = F)
sampleTimes <- index(amzn)

#Select only those that were collected on 2012
collected2012 <- sampleTimes[grep('^2012', sampleTimes)]
length(collected2012)

#Select only those that wew collected on Monday in 2012
onMondays <- collected2012[weekdays(collected2012) == "lunes"]
length(onMondays)
