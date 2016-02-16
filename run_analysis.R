# Download and unzip the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="UCI_Smartphone.zip", method="curl")
unzip(zipfile="UCI_Smartphone.zip", exdir="./")
## The folder containing our raw data is "UCI HAR Dataset"
setwd('UCI HAR Dataset/')

# Read the Data we Need

## 3 main component of the data : "features", "activity", and "subject"

# Features Data
testFeatures  <- read.table('./test/X_test.txt')
trainFeatures <- read.table('./train/X_train.txt')


# Activity Data
testActivity <- read.table('./test/y_test.txt')
trainActivity <- read.table('./train/y_train.txt')

# Subject Data
testSubject <- read.table('./test/subject_test.txt')
trainSubject <- read.table('./train/subject_train.txt')


# Merge training and test sets
features <- rbind(testFeatures, trainFeatures)
activity <- rbind(testActivity, trainActivity)
subject <- rbind(testSubject, trainSubject)

## Extract feature names
names(activity) <- "activity"
names(subject) <- "subject"
featureNames <- read.table('./features.txt')
names(features) <- featureNames$V2

## Create the data frame 
smartphoneData <- data.frame(features, subject, activity)

# Extract only measurements of mean and standard deviation for each measurement.
MeanAndStd <- grep("mean()|std()|Label|Subject", featureNames[, 2])

# MeanAndStd : mean and standard deviation variables in the features data
# column 562 : subject data
# column 563 : activity data
smartphoneData_MeanStd <- smartphoneData[c(MeanAndStd,562,563)]


# Uses descriptive activity names to name the activities in the data set
activityNames <- read.table('./activity_labels.txt')
smartphoneData_MeanStd$activity <- factor(smartphoneData_MeanStd$activity, 
                                          levels = activityNames$V1, 
                                          labels = activityNames$V2)


# Appropriately labels the data set with descriptive variable names.

# 1. features beginning with "t" and "f" stand for 'time' and 'frequency' respectively.
# 2. "Acc" = Accelerometer
# 3. "BodyBody" = Body
# 4. "Gyro" = Gyroscope
# 5. "Mag" = Magnitude

names(smartphoneData_MeanStd) <- gsub("^t", "time", names(smartphoneData_MeanStd))
names(smartphoneData_MeanStd) <- gsub("^f", "frequency", names(smartphoneData_MeanStd))
names(smartphoneData_MeanStd) <- gsub("Acc", "Accelerometer", names(smartphoneData_MeanStd))
names(smartphoneData_MeanStd) <- gsub("Gyro", "Gyroscope", names(smartphoneData_MeanStd))
names(smartphoneData_MeanStd) <- gsub("Mag", "Magnitude", names(smartphoneData_MeanStd))
names(smartphoneData_MeanStd) <- gsub("BodyBody", "Body", names(smartphoneData_MeanStd))

# From the data set in step 4, create a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
smartPhoneAverages <- aggregate(. ~subject + activity, smartphoneData_MeanStd, mean)
smartPhoneAverages <- smartPhoneAverages[order(smartPhoneAverages$subject, smartPhoneAverages$activity),]
write.table(smartPhoneAverages, file = 'smartPhoneAverages.txt', row.name = FALSE)
