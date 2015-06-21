#WEARABLE COMPUTING DATA CODEBOOK
Version 1.0

This dataset merges wearable computing data downloaded from the UCI HAR Dataset into a tidy dataframe, and separately reports the average of each mean and standard deviation measure for each subject and activity.

The features for this dataset come from the Human Activity Recognition Using Smartphones Dataset.  For detailed information on the origin of the data, refer to link 1 below.  The data can be downloaded from link 2 below.

**link 1**: "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"  
**link 2**: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%#20Dataset.zip"


The following section summarizes the tidy dataset "Wearable_Data_150620.txt" (hereafter referred to as "df.tidy" as in the R script).

df.tidy reports various signals taken from the phones of 30 volunteers at regular 50 Hz intervals while they were performing certain activities.  The first two columns of df.tidy identify the volunteer and activity that was being performed.  The following 179 variables refer to distinct mean or standard deviation measures of phone sensor activity. Each observation (row) represents the measures that were taken for each of the various sensors for each subject (volunteer) and for each activity. 

tidy.df includes the following columns:

- **subject (int, values 1-30):** refers to the volunteer and corresponds to the train and test subjects from the original dataset.
- **activity (factor with 6 levels):** refers to the specific activity as described in "activity_labels.txt" of the original dataset.  Distinct values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
- **Columns 3-181** are taken directly from "features.txt".  For information on which features were included, see the section on transformations below.  Refer to the original dataset's "ReadMe" and "features_info.txt" docs for full details on each variable.

The following files were read from the original dataset:

	- activity_labels.txt
	- features.txt
	- subject_train.txt
	- X_train.txt
	- Y_train.txt
	- subject_test.txt
	- X_test.txt
	- Y_test.txt

The following section describes the transformations that were performed to the original dataset to derive df.tidy:

First, the single column vector features.txt was assigned to the column names for the data from X_test and X-train.  These represent the "measures" of each sensor variable. Next, the activity labels from activity_labels.txt were merged with the data from Y_test and Y_train (using the first column, which identifies the activity by numeric code) so that each activity was easily identifiable by explicit strings rather than numeric coding (note that the merge was performed after converting the data from factor form to character form.  This ensures that the records are not mixed out of order when they are subsequently combined with the measures data).  Next, the data for each subject, activity and measure were appended together via column bind (cbind).  Next, only those variables that contain the string "mean" or "std" in the column name were selected and all others removed (aside from the subject and activity of course).  Finally, the training and test datasets are combined via rbind to make one dataset.

These actions produce a tidy data set as each row is an observation of a volunteer performing a certain activity at a certain point in time and each column is a distinct variable (be it the volunteer/subject, the activity, or some measure of a sensor variable).

