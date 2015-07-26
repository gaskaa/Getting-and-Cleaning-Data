#Coursera Data Science
#Getting and Cleaning Data
#Course Project
#Last Modified: 7/25/15
#========================================================================================
# Using data from the UCI Human Activity Recognition Using Smartphones Data Set here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
# This R script does the following: 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the
#    average of each variable for each activity and each subject.


# Download file, save date downloaded, and unzip
#fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileURL, destfile="UCIdata.zip", method="curl")
#dataDownloaded<-date()
#unzip("UCIdata.zip")
#Lines 18-21 above can be used to download data to working directory and unzip

# Load packages
library(plyr)

# Load the test and training data into R
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
Ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
Ytrain <- read.table("./UCI HAR Dataset/train/Y_train.txt")

# Load the activity labels and features into R (will use to make col names)
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

# Assign column names to test and train data based on activities and features
colnames(activities) <- c("Activity.Number" , "Activity.Type")
colnames(subjectTest) <- "Subject.Number"
colnames(Xtest) <- features[,2] # The second column of features has the labels we want
colnames(Ytest) <- "Activity"
colnames(subjectTrain) <- "Subject.Number"
colnames(Xtrain) <- features[,2]
colnames(Ytrain) <- "Activity"

# Merge all of the X data, Y data, and subject data separately 
# (dim(Xdata)=10299*561, dim(Ydata)=10299*1, dim(subjectData)=10299*1)
Xdata <- rbind(Xtest, Xtrain)
Ydata <- rbind(Ytest, Ytrain)
subjectData <- rbind(subjectTest, subjectTrain)

# Fully merge the test and train data (*STEP 1*)
# (dim(mergedData)=10299*563)
mergedData <- cbind(subjectData, Ydata, Xdata)

# Extract only the measurements on the mean and standard deviation for each measurement (*STEP 2*)
# (dim(MeanStdData)=10299*66)
MeanStdData <- mergedData[, grep("mean\\(\\)|std\\(\\)", names(mergedData))]

# Merge the mean and standard deviation data with the subject numbers and activity numbers
# (dim(data)=10299*68)
data <- cbind(subjectData, Ydata, MeanStdData)

# Clean up the activity column by replacing the activity number with the corresponding 
# activity (*STEP 3*)
data$Activity[data$Activity == 6] <- "LAYING"
data$Activity[data$Activity == 5] <- "STANDING"
data$Activity[data$Activity == 4] <- "SITTING"
data$Activity[data$Activity == 3] <- "WALKING DOWNSTAIRS"
data$Activity[data$Activity == 2] <- "WALKING UPSTAIRS"
data$Activity[data$Activity == 1] <- "WALKING"

# Clean up the subject number column by ordering
orderedData <- data[order(data$Subject.Number),]

# Clean up the other variable column names (*STEP 4*)
names(orderedData) <- gsub("-", " ", names(orderedData))
names(orderedData) <- gsub("^(t)", "Time ", names(orderedData))
names(orderedData) <- gsub("^(f)", "Freq ", names(orderedData))
names(orderedData) <- gsub("std", "Std", names(orderedData))
names(orderedData) <- gsub("mean", "Mean", names(orderedData))
names(orderedData) <- gsub("\\(\\)", "", names(orderedData))
names(orderedData) <- gsub("Body", "Body ", names(orderedData))
names(orderedData) <- gsub("Gravity", "Gravity ", names(orderedData))


# Maybe not necessary to put all these spaces in the variable names 
# but it looks better/more "tidy"
names(orderedData) <- gsub("Subject.Number", "Subject", names(orderedData))
names(orderedData) <- gsub("AccJerk", "Acc Jerk", names(orderedData))
names(orderedData) <- gsub("GyroJerk", "Gyro Jerk", names(orderedData))
names(orderedData) <- gsub("JerkMag", "Jerk Mag", names(orderedData))
names(orderedData) <- gsub("GyroMag", "Gyro Mag", names(orderedData))
names(orderedData) <- gsub("AccMag", "Acc Mag", names(orderedData))
names(orderedData) <- gsub("Body Body", "Body", names(orderedData))

# Now create a second, independent tidy data set with the
# average of each variable for each activity and each subject (*STEP 5*)
#(dim(TidyData)=180*68)
TidyData <- ddply(orderedData, .(Subject, Activity), numcolwise(mean))

# Write tidy data to a txt file
write.table(TidyData, "mean_data.txt", row.name=FALSE)
