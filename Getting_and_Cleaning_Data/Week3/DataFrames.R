library(jpeg)
library(data.table)
library(dplyr)

setwd('./Getting_and_Cleaning_Data/Week3')

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = 'survey.csv')

df <- read.csv('survey.csv', header = T)
agricultureLogical <- df$AGS == 6 & df$ACR == 3
which(agricultureLogical)


download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg', destfile = 'image.jpg')
image <- readJPEG('image.jpg', native = T)
quantile(image, probs = c(0.3, 0.8))

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', destfile = 'gdp.csv')
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', destfile = 'education.csv')

gdp <- fread('gdp.csv', skip = 5, nrows = 190, select = c(1, 2, 4, 5), col.names = c("CountryCode", "Rank", "Economy", "Total"))
edu <- read.csv('education.csv', header = T)

new_df <- merge(gdp, edu, by = 'CountryCode')
nrow(new_df)

income <- new_df %>%
    filter(Income.Group == 'High income: OECD' | Income.Group == 'High income: nonOECD') %>%
    group_by(Income.Group) %>%
    summarize(Average = mean(Rank, na.rm = T))


new_df$RankGroups <- cut(new_df$Rank, breaks = 5)
table(new_df$RankGroups, new_df$Income.Group)