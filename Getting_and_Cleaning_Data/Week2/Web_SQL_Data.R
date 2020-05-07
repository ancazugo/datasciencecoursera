library(XML)
library(httr)
library(sqldf)

setwd('./Getting_and_Cleaning_Data/Week1')

url <- url('http://biostat.jhsph.edu/~jleek/contact.html')
htmlCode <- readLines(url)
close(url)
htmlCode
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])


html <- htmlParse(htmlCode, useInternalNodes = T)

htmlCode2 <- GET('http://biostat.jhsph.edu/~jleek/contact.html')
content2 <- content(htmlCode2, as = 'text')
parsedHtml <- htmlParse(content2, asText = T)
xpathSApply(parsedHtml, '//body', xmlValue)

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv', destfile = './acs.csv')
acs <- read.csv('acs.csv', header = T)
over50 <- sqldf('SELECT pwgtp1 from acs where AGEP < 50')
uniqueAGEP <- sqldf('SELECT distinct AGEP from acs')
uniqueAGEP
