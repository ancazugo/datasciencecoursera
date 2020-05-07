library(xlsx)
library(XML)
library(data.table)

setwd('./Getting_and_Cleaning_Data/Week1')
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = './Community_Survey')

df <- read.csv('Community_Survey', header = T)

value <- df$VAL

greaterThan1M <- val[val >= 24]
length(greaterThan1M)

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx', destfile = './Gas_Aquisition.xlsx')
gas <- read.xlsx('Gas_Aquisition.xlsx', header = T, sheetIndex = 1, colIndex = 7:15, rowIndex = 18:23)

url1 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
doc <- xmlTreeParse(url, , useInternalNodes = F, )
rootNode <- xmlRoot(doc)

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = './Community_Survey.csv')
df2 <- fread('Community_Survey.csv', header = T)
df2$
