### Introduction

This R script is provided as the project for the "Getting and Cleaning Data"
course. The purpose of this project is to demonstrate your ability to
collect, work with, and clean a data set. The goal is to prepare tidy
data that can be used for later analysis. The data linked to from the
course website represent data collected from the accelerometers from the
Samsung Galaxy S smartphone.

### Source

This R script queries the data available in: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Acknowledgement:

Use of this dataset in publications must be acknowledged by referencing the
following publication [1]:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
    Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using
    a Multiclass Hardware-Friendly Support Vector Machine. International
    Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, 
    Spain. Dec 2012

### Procedure

1. Unzip the source zip file, specified above, in your working directory.

2. Open R studio.

3. Set your working directory, which must be where the unzipped folder 
   "UCI HAR Dataset" is located on your computer.

4. Execute the following command: source("run_analysis.R")

5. The output will be a tidy data set, provided in the data table "result".
   Execute the following R command to view the first 10 observations in the
   data set: head(result, 10)

6. Look for the output file "data_averages.txt" in your working directory
   containing the generated tidy data set with the average of each variable 
   for each activity and each subject.

### Code Book

A code book is provided which defines each variable and output table created
by this R script.
