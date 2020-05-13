setwd('./Getting_and_Cleaning_Data/Week4/Project')
library(data.table)
library(dplyr)

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', destfile = 'wearable.zip')

#Load features and activities as data.frames
features <-fread('UCI HAR Dataset/features.txt', col.names = c('n', 'Measure'))
activities <- fread("UCI HAR Dataset/activity_labels.txt", col.names = c("Code", "Activity"))

#Load the train files with the features as column names on X
trainSubject <- fread('UCI HAR Dataset/train/subject_train.txt', col.names = 'Subject')
trainX <- fread('UCI HAR Dataset/train/X_train.txt', header = F, col.names = features$Measure)
trainY <- fread('UCI HAR Dataset/train/Y_train.txt', header = F, col.names = 'Code')

#Bind train data.frames by columns
train_df <- cbind(trainSubject, trainY, trainX)

#Load the test files with the features as column names on X
testSubject <- fread("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
testX <- fread('UCI HAR Dataset/test/X_test.txt', header = F, col.names = features$Measure)
testY <- fread('UCI HAR Dataset/test/Y_test.txt', header = F, col.names = 'Code')

#Bind test data.frames by columns
test_df <- cbind(testSubject, testY, testX)

#Bind train and test data.frames by rows
df <- rbind(train_df, test_df)

#Add activity names on df, change column name to Activity and change them to lowercase
df$Code <- activities[df$Code, 2]
names(df)[2] <- 'Activity'
df$Activity <- tolower(df$Activity)

#Get only columns that are mean or standard deviation
selectedColumns <- c(1, 2, grep('mean|std', names(df)))
df2 <- df[, ..selectedColumns]

#Change column names to a proper form
names(df2) <- gsub('^t', 'Temperature', names(df2))
names(df2) <- gsub('(^f|Freq)', 'Frequency', names(df2))
names(df2) <- gsub('BodyBody', 'Body', names(df2))
names(df2) <- gsub('Acc', 'Accelerometer', names(df2))
names(df2) <- gsub('Gyro', 'Gyroscope', names(df2))
names(df2) <- gsub('Mag', 'Magnitude', names(df2))
names(df2) <- gsub('-mean', 'Mean', names(df2))
names(df2) <- gsub('-std', 'STD', names(df2))
names(df2) <- gsub('\\(\\)', '', names(df2))
names(df2) <- gsub('\\-', '_', names(df2))

#Group by subject and activity and get the mean
tidy_df <- df2 %>%
    group_by(Subject, Activity) %>%
    summarise_all(., .funs = mean)