#<u>How the script works</u><br/>


Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip<br/>
 
Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones<br/>
 
The attached R script (run_analysis.R) performs the following to clean up the data:<br/>

1. Combine train and test data<br/>
 Combine the X_train.txt and X_test.txt<br/>
 Combine the subject_train.txt and subject_test.txt<br/>
 Combine the y_train.t and y_test.txt<br/>

2. Extracts only the mean and standard deviation for each measurement.<br/>
 using the features.txt get the indeces of mean and and stander deviation<br/>

3. Uses descriptive activity names to name the activities in the data set.<br/>
 using the activity_labels.txt provided and use it as labels<br/>

4.Label the data set with descriptive activity names<br/>

5.Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.<br/>
6.Iterate on the number of subjects and number of activities<br/>
7.Write the result to a file using write.table and setting the the row.name=FALSE.<br/>



 