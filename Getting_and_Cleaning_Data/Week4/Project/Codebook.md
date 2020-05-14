# Codebook of Getting and Cleaning Data Project
1. Load the different files in train and test folders
2. Merge both train and test datasets along with subject Datasets
3. Change activity names from numbers to string
4. Select only columns that show mean and standard deviation of measures
4. Use regular expressions to name appropiately the variables
5. Create a final dataset grouped by test subject and activity and summarize with the mean of each variable
6. Save the final dataFrame as a txt

## Variables
Modified from the original description: The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. These Time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner Frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (`TimeBodyAcceleration_XYZ` and `TimeGravityAcceleration_XYZ`) using another low pass Butterworth filter with a corner `Frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in `Time to obtain Jerk signals (`TimeBodyAccelerationJerk_XYZ` and `TimeBodyGyroscopeJerk_XYZ`). Also the Magnitude` of these three-dimensional signals were calculated using the Euclidean norm (`TimeBodyAccelerationMagnitude`, `TimeGravityAccelerationMagnitude`, `TimeBodyAccelerationJerkMagnitude`, `TimeBodyGyroscopeMagnitude`, `TimeBodyGyroscopeJerkMagnitude`).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing `FrequencyBodyAcceleration_XYZ`, `FrequencyBodyAccelerationJerk_XYZ`, `FrequencyBodyGyroscope_XYZ`, `FrequencyBodyAccelerationJerkMagnitude`, `FrequencyBodyGyroscopeMagnitude`, `FrequencyBodyGyroscopeJerkMagnitude`.

These signals were used to estimate variables of the feature vector for each pattern:   '_XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

`TimeBodyAcceleration_XYZ`
`TimeGravityAcceleration_XYZ`
`TimeBodyAccelerationJerk_XYZ`
`TimeBodyGyroscope_XYZ`
`TimeBodyGyroscopeJerk_XYZ`
`TimeBodyAccelerationMagnitude`
`TimeGravityAccelerationMagnitude`
`TimeBodyAccelerationJerkMagnitude`
`TimeBodyGyroscopeMagnitude`
`TimeBodyGyroscopeJerkMagnitude`
`FrequencyBodyAcceleration_XYZ`
`FrequencyBodyAccelerationJerk_XYZ`
`FrequencyBodyGyroscope_XYZ`
`FrequencyBodyAccelerationMagnitude`
`FrequencyBodyAccelerationJerkMagnitude`
`FrequencyBodyGyroscopeMagnitude`
`FrequencyBodyGyroscopeJerkMagnitude`

For each one of the variables per axis, there is a column with the Mean (Mean) and the Standard Deviation (STD).