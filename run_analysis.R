library(data.table)
library(dplyr)


## Download and unzip the files

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "uci.zip", method = "curl")
unzip("uci.zip")

## Load data files

activityLabels<- read.table("UCI HAR Dataset/activity_labels.txt")
features<- read.table("UCI HAR Dataset/features.txt")
xtest<- read.table("UCI HAR Dataset/test/X_test.txt")
ytest<- read.table("UCI HAR Dataset/test/Y_test.txt")
subtest<- read.table("UCI HAR Dataset/test/subject_test.txt")
xtrain<- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain<- read.table("UCI HAR Dataset/train/Y_train.txt")
subtrain<- read.table("UCI HAR Dataset/train/subject_train.txt")

## Merge Data
xall <- rbind(xtest, xtrain)
yall <- rbind(ytest, ytrain)
suball<- rbind(subtest, subtrain)

### Name columns
colnames(xall)<- t(features[2])
colnames(yall)<- "Activity"
colnames(suball)<- "Subject"

allData<- cbind(xall, yall, suball)

## Extract only mean and standard deviation
featuresNeeded <- grep(".*mean.*|.*std.*", names(allData), ignore.case = TRUE)

## Add activity and subject columns
finalColumns<- c(featuresNeeded, 562, 563)
finalData<- allData[,finalColumns]

##Name Activities in data set
finalData$Activity <- as.character(finalData$Activity)
for (i in 1:6) { finalData$Activity[finalData$Activity == i] <- as.character(activityLabels[i,2])
  
}

finalData$Activity<- as.factor(finalData$Activity)

## Add appropriate label names
names(finalData)
## Here you can see their are abbreviated names that need to be replaced: Gyro = Gyroscope, Acc = Accelerometer, BodyBody = Body, Mag = Magnitude, f = Frequency, t = time

## Change names
names(finalData) <- gsub("Gyro", "Gyroscope", names(finalData))
names(finalData) <- gsub("Acc", "Accelerometer", names(finalData))
names(finalData) <- gsub("BodyBody", "Body", names(finalData))
names(finalData) <- gsub("Mag", "Magnitude", names(finalData))
names(finalData) <- gsub("^f", "Frequency", names(finalData))
names(finalData) <- gsub("^t", "Time", names(finalData))
names(finalData) <- gsub("-mean()", "Mean", names(finalData))
names(finalData) <- gsub("-std()", "STD", names(finalData))
names(finalData) <- gsub("-freq()", "Frequency", names(finalData))
names(finalData) <- gsub("angle", "Angle", names(finalData))
names(finalData) <- gsub("gravity", "Gravity", names(finalData))

names(finalData)

##Create a second, independent tidy data set with the average of each variable for each activity and each subject.

finalData$Subject <- as.factor(finalData$Subject)
finalData<- data.table(finalData)

tidyData<- aggregate(. ~ Subject + Activity, finalData, mean)
write.table(tidyData, file = "tidy.txt", row.names = FALSE)
View(tidyData)
