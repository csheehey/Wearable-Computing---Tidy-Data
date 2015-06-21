##############################################################################
# This script merges wearable computing data downloaded from the UCI HAR     #
# Dataset into a tidy dataframe called "df.tidy".  The means of all mean and #
# standard deviation measures are calculated for each subject and activity   #
# and reported in a dataframe called "df.means". Data can be downloaded from #
# "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR% #
#  20Dataset.zip"                                                            #
##############################################################################

   # load libraries
library(dplyr)

   # load first files
labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
subject.train <- read.table("./train/subject_train.txt", col.names = "subject")
measures.train <- read.table("./train/X_train.txt")
activity.train <- read.table("./train/Y_train.txt")
subject.test <- read.table("./test/subject_test.txt", col.names = "subject")
measures.test <- read.table("./test/X_test.txt")
activity.test <- read.table("./test/Y_test.txt")

   # define column names of measures from features (principle of tidy data)
colnames(measures.test) <- colnames(measures.train) <- features[, 2]
colnames(measures.train) <- features[, 2]

   # convert labels character vector and merge with activity data
labels[, 2] <- as.character(labels[, 2])  # ensures data does not get mixed up during merge
activity.test <- inner_join(activity.test, labels)  # "by" automatically recognized as v1
activity.train <-  inner_join(activity.train, labels)  # "by" automatically recognized

   # combine observations from train and test set together
test.df <- cbind(subject.test, 
                 activity = activity.test[, 2],  # descriptive col name
                 measures.test)
train.df <- cbind(subject.train,  
                  activity = activity.train[, 2],  # descriptive col name
                  measures.train)

   # combine test and training sets together. Okay to do this now.
df.tidy <- rbind(train.df, test.df)

   # select first two columns and those that contain mean or std in col name
include.cols <- grepl("mean", colnames(df.tidy)) | grepl("std", colnames(df.tidy))
include.cols[1:2] = TRUE  # keep first 2 cols (subject & activity)

df.tidy <- df.tidy[, include.cols]   # data is now tidy. Each row is an observation; each
                                # variable is a column.

   #  Calc avg of each mean/std measure for each activity and subject 
df.means <- aggregate(df.tidy[3:ncol(df.tidy)], 
                      list(subject = df.tidy$subject, activity = df.tidy$activity), 
                      mean)

   # remove unneeded data
rm(list = setdiff(ls(), ls(pattern = "df.")))

   # write data to csv
write.table(df.tidy, "Wearable_Data_150620.txt", row.names = F)

