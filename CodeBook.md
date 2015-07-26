#Getting and Cleaning Data Course Project

This is information on the data, variables, and data cleaning process used in `run_analysis.R`. The R script takes the data through 5 steps, outlined below.

##Data Source

As stated in “README.md”, the data used is the [Human Activity Recognition Using Smartphones Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

###Data Information from UCI Machine Learning Repository

The data is described in the following way (more information can be found in txt files within the data set):

“The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.”

###Attribute Information

“For each record in the dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.”

##Part 1: Merge the training and the test sets to create one data set

The unzipped data file contains a “test” file and a “train” file. Each file contains a set of X data, a set of Y data, and a set of subject data. The Y components of the test and train folders are composed of numbers 1 through 6 which correspond to activities found in the `activity_labels.txt` (walking, standing, laying, etc). The subject components of the test and train folders contain the ID numbers of the 30 subjects studied. The X components of the test and train folders are a set of observations for each activity and subject. The `features.txt` file contains labels/features for the observations in the X components.

A total of 8 files are loaded into R to create:
`subjectTest`, `Xtest`, `Ytest`, `subjectTrain`, `Xtrain`, `Ytrain`, `activities`, `features`

The features are used to label to `Xtrain` and `Xtest` data before merging. The X components, Y components, and subject data are each row bound before being column bound all together to merge.

##Part 2: Extract only mean and standard deviation elements

Only measurements on the mean and standard deviation for each measurement are extracted. This subset is named `MeanStdData`.

##Part 3: Use descriptive activity names to name the activities in the data set

The subject and activity columns are attached to the mean and standard deviation subset and named `data`. Each number in the activity column is replaced with the corresponding activity description. The data is then ordered by subject number and named `orderedData`. 

##Part 4: Appropriately label the data set with descriptive variable names

Features labels were used to name the columns in part 1 but the names were not clear. Here spaces are added between words, unnecessary symbols are removed, words are capitalized, and some abbreviations are made more clear. 

##Part 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

The mean of each variable for each activity and each subject is calculated. This way, there is one set of observations for each of the six activities a subject performs.  This tidy data, named `TidyData`, is put into a txt file named `mean_data.txt`.






