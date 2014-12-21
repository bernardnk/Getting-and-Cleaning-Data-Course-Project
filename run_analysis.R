# Source: This R script queries the data available in: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Acknowledgement:
# Use of this dataset in publications must be acknowledged by referencing the 
# following publication [1]:
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
#     Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using
#     a Multiclass Hardware-Friendly Support Vector Machine. International
#     Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, 
#     Spain. Dec 2012

if("data.table" %in% rownames(installed.packages()) == FALSE) {install.packages("data.table")}
library(data.table)

# This R script queries the data available in: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# and performs the following:

#############################
# 1. Merges the training and the test sets to create one data set.
#############################
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test  <- read.table("UCI HAR Dataset/test/subject_test.txt")
S_all <- rbind(subject_train, subject_test)

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test  <- read.table("UCI HAR Dataset/test/X_test.txt")
X_all <- rbind(X_train, X_test)

Y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
Y_test  <- read.table("UCI HAR Dataset/test/y_test.txt")
Y_all <- rbind(Y_train, Y_test)

#############################
# 2. Extracts only the measurements on the mean and standard deviation for 
#    each measurement. 
#############################
# Get all observation variable names in a features table
features <- read.table("UCI HAR Dataset/features.txt")

# Grep for variable names starting that include -mean() or -std()
meanOrStd <- grep("-std\\(\\)|-mean\\(\\)", features[, 2])
X_all <- X_all[, meanOrStd]
names(X_all) <- features[meanOrStd, 2]
names(X_all) <- gsub("\\(|\\)", "", names(X_all))

#############################
# 3. Uses descriptive activity names to name the activities in the data set
#############################
# Use the activity_labels table to clarify the activity names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
Y_all[,1] = activity_labels[Y_all[,1], 2]

#############################
#4. Appropriately labels the data set with descriptive variable names. 
#############################
names(Y_all) <- "activity"
names(S_all) <- "subject"
# Combine (bind) all data into merged table
merged <- cbind(S_all, Y_all, X_all)

#############################
#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
#############################

# Determine the table size, first how many subjects
subjectList = unique(S_all)[,1]
subjectCnt = length(subjectList)

# Get how many activities can exist for each subject
activityCnt = nrow(activity_labels)

# Get the number of columns, i.e. list of mean and std, based on the previously
# generated merged table
numCols = dim(merged)[2]

# Format an output table "result" to store the average of each variable for
# each activity and each subject
result = merged[1:(subjectCnt*activityCnt), ]

# For each subject and each activity, get all matching records in the merged
# table and perform a colMeans on each variable type.
row = 1
for (s in 1:subjectCnt) {
        for (a in 1:activityCnt) {
        		# Build each row
                result[row, 1] = subjectList[s]
                result[row, 2] = activity_labels[a, 2]
                tmp <- merged[merged$subject==s & merged$activity==activity_labels[a, 2], ]
                result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
                row = row+1
        }
}

# sort the result table by subject and activity
result <- arrange(result, subject, activity)

# generate tidy data file
write.table(result, file = "data_averages.txt", row.name=FALSE)
