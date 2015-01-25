# Data used on this project can be downloaded at 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# This R script does the following:

# 1. combine the test sets and training data create one data set.


y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
Y_train_test <- rbind(y_train, y_test)


x_train <- read.table("train/X_train.txt")
x_test <- read.table("test/X_test.txt")
X_train_test <- rbind(x_train, x_test)

s_train <- read.table("train/subject_train.txt")
s_test <- read.table("test/subject_test.txt")
S_train_test <- rbind(s_train, s_test)


# 2. Extracts only the mean and standard deviation for each measurement.


featuresLabel <- read.table("features.txt")
indices_of_mean_and_std <- grep("-mean\\(\\)|-std\\(\\)", featuresLabel[, 2])

X_train_test <- X_train_test[, indices_of_mean_and_std]
names(X_train_test) <- featuresLabel[indices_of_mean_and_std, 2]

names(X_train_test) <- gsub("\\(|\\)", "", names(X))
names(X_train_test) <- tolower(names(X_train_test))

# 3. Uses descriptive activity names to name the activities in the data set.
# read the activity_labels.txt provided and use it as labels
activitiesLabel <- read.table("activity_labels.txt")
activitiesLabel[, 2] = gsub("_", "", tolower(as.character(activitiesLabel[, 2])))
Y_train_test[,1] = activitiesLabel[Y_train_test[,1], 2]
names(Y_train_test) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.
names(S_train_test) <- "subject"
SYX_cleanedData <- cbind(S_train_test, Y_train_test, X_train_test)
write.table(cleaned, "merged_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable
#    for each activity and each subject.

distinctSubjects = unique(S_train_test)[,1]
numOfSubjects    = length(distinctSubjects)
numOfActivities  = length(activities[,1])
numOfCols        = dim(SYX_cleanedData)[2]
results         = SYX_cleanedData[1:(numOfSubjects*numActivities), ]


#iterate on the data
row = 1
for (s in 1:numOfSubjects) {
  for (a in 1:numOfActivities) {
    results[row, 1] = distinctSubjects[s]
    results[row, 2] = activities[a, 2]
    tmp <- cleanedData[cleanedData$subject==s & cleanedData$activity==activities[a, 2], ]
    results[row, 3:numOfCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}

#write the data to text file
write.table(result, "data_set_with_the_averages_with_rowname_false.txt", row.name=FALSE)
