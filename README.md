How the script works
========================

Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The attached R script (run_analysis.R) performs the following to clean up the data:

#1. Combine train and test data
## Combine the X_train.txt and X_test.txt
## Combine the subject_train.txt and subject_test.txt
## Combine the y_train.t and y_test.txt

#2. Extracts only the mean and standard deviation for each measurement.
## using the features.txt get the indeces of mean and and stander deviation

#3. Uses descriptive activity names to name the activities in the data set.
## using the activity_labels.txt provided and use it as labels 

#4.Label the data set with descriptive activity names

#5.Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
#6.Iterate on the number of subjects and number of activities
#7.Write the result to a file using write.table and setting the the row.name=FALSE.



 