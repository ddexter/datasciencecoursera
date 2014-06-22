# Getting and Cleaning Data - Final Project
The final project for this course is to sanitize the "Human Activity Recognition Using Smartphones" data set by first extracting only the mean and std measurements while also concatenating the test and training sets.  The activity id's are replaced with meaningful names that explain what each activity entailed.  Once the mean and standard deviations of each measurement are extracted, the script creates a new tidy data set that finds the average across all the extracted measurements for each unique (subject, activity) pair.  The resulting table, written to tidy_avg_subject_activity.txt, has a mean for each mean() and std() measurement form the original data set and one row per (subject/activity).  The subject and activity are listed in separate columns to respect the tidy nature of the data

## Extracting and Combining Existing Data
The file contains several helper methods for extracting and combining the test and training data.  We first extract the subject vector.  We also read the column names and activity id to activity names into separate hash maps to convert the column names and activity id's to meaningful names in our aggregated data frame.  The extract_data function reads the X, y, and subject files, forming a data frame of the aggregated information (after replacing activity id.'s with the actual activity name).  This is performed for the training set and test set, with the result of the two being sorted and combined.  The correct mean and std columns are identified by using R's grepl() command to match "mean()" and "std()" such that all non-matching columns are ignored.

## Averaging Extracted Data
The data frame described in the previous section contains many rows with duplicate (subject, activity) readings.   This part of the project asks us to average each mean() and std() measurement for each unique group of (subject, activity) pairs.  We use R's aggregate function to group by subject and activity and then apply the mean function to each group, resulting in a data frame that has one row for each unique (subject, activity) pair.  Every additional column represents the average of all values in the matching column's group.