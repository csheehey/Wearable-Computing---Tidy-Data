##WEARABLE COMPUTING DATA README
Version 1.0

The files in this repo are derived from the Human Activity Recognition Using Smartphones Dataset. The following section describes each file and how it relates to the others:

**CodeBook.MD:** provides detail on each variable and describes how the data was transformed from the original HAR dataset.

**Wearable_Data_150620.txt:** contains the tidy data that is output from run_analysis.R as the dataframe "df.tidy". Written to a txt file without row names.

**run_analysis.R:** the primary script which produces the two text files above.  The script reads from your working directory select files from the HAR dataset.  It then combines the files into a tidy dataset called "df.tidy" that includes information on each subject, activity and sensor variable related to mean or  standard deviation from both the test and training sets.  Next, the script calculates the mean of each sensor measure for each subject and activity and stores this as a separate object called "df.means".  Finally, the script removes all unneeded data objects and writes "df.tidy" to a text file (see above).
