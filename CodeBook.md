### Introduction

This R script is provided as the project for the "Getting and Cleaning Data"
course. The purpose of this project is to demonstrate your ability to
collect, work with, and clean a data set. The goal is to prepare tidy
data that can be used for later analysis. The data linked to from the
course website represent data collected from the accelerometers from the
Samsung Galaxy S smartphone.

### File Name

run_analysis.R

### Source

This R script queries the data available in: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Description

The script performs the following:


## Merges the training and the test sets to create one data set.

subject_train - contains training data for the subjects who performed 
the activity for each window sample.

subject_test - contains test data for the subjects who performed 
the activity for each window sample.

S_all - combines the rows in subject_train and subject_test into a single
data table.

X_train - contains the training set.
X_test -  contains the test set.
X_all - combines the rows in X_train and X_test into a single data table.

Y_train - contains the Training labels.
Y_test -  contains the Test labels.
Y_all - combines the rows in Y_train and Y_test into a single data table.


## Extracts only the measurements on the mean and standard deviation for 
each measurement. 

Get all observation variable names in a features data table called "features".

Grep for variable names starting that include -mean() or -std().
meanOrStd - contains all column names that include -mean() or -std().
meanOrStd is used to filter the associated observations in X_all.


## Uses descriptive activity names to name the activities in the data set

activity_labels - the activity_labels table is used to map the activity
names in Y_all.


## Appropriately labels the data set with descriptive variable names. 

merged - data table used to combine all tables into associated observations.


## From the data set in step 4, creates a second, independent tidy data set 
with the average of each variable for each activity and each subject.

subjectList - unique subjects list.

subjectCnt - how many unique subjects.

activityCnt - how many activities can exist for each subject.

numCols - number of columns, i.e. list of mean and std, based on the previously
generated merged table.

The main operation is that for each subject and each activity, get all matching 
records in the merged table and perform a colMeans on each variable type.

result - data table storing the average of each variable for each activity
and each subject.

The result table is then sorted by subject and activity.

Generated tidy data file "data_averages.txt" from data table "result".
