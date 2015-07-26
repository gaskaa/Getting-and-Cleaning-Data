#Getting-and-Cleaning-Data Course Project

##Introduction
This repository was made for the Course Project portion of Getting and Cleaning Data from John’s Hopkins  University via Coursera. The goal of the course project is to demonstrate ability to collect, work with, and clean a set of data. The end product is a tidy data set that can be used for later analysis. 

The data used is from the  UCI Machine Learning Repository here

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The actual data (Human Activity Recognition Using Smartphones Data Set) is zipped here

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> 

##The Script
The R script `run_analysis.R` reads the data, cleans it up, and extracts a set of mean values. Lines 18-21 in the code are commented out but can be uncommented and used to download the data directly to the current working directory and unzip it. If the data is already unzipped in the working directory, these lines are not needed. The output is a file called `mean_data.txt`, which contains the tidy data.

##More Information
More information about the data, variables, and the steps taken to clean the data are detailed in “CodeBook.md”, also found in this repository. 