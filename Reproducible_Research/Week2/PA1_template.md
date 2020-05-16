---
title: "Reproducible Research: Peer Assessment 1"
output: 
  html_document:
    keep_md: true
---


## Loading necessary packages

```r
library(ggplot2)
library(lubridate)
```


## Loading and preprocessing the data

```r
activity <- read.csv('activity.csv')
activity$date <- as.POSIXct(activity$date)
```




## What is mean total number of steps taken per day?



## What is the average daily activity pattern?



## Imputing missing values



## Are there differences in activity patterns between weekdays and weekends?
