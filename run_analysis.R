# Data used on this project can be downloaded at 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# This R script does the following:

# 1. combine the test sets and training data create one data set.
 
x_train <- read.table("train/X_train.txt")
x_test <- read.table("test/X_test.txt")
X <- rbind(x_train, x_test)

s_train <- read.table("train/subject_train.txt")
s_test <- read.table("test/subject_test.txt")
S <- rbind(s_train, s_test)

y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
Y <- rbind(y_train, y_test)

# 2. Extracts only the mean and standard deviation for each measurement.


features <- read.table("features.txt")
indices_of_mean_and_std <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])

X <- X[, indices_of_mean_and_std]
names(X) <- features[indices_of_mean_and_std, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.
# read the activity_labels.txt provided and use it as labels
activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.
names(S) <- "subject"
cleaned <- cbind(S, Y, X)
write.table(cleaned, "merged_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(S)[,1]
numSubjects    = length(unique(S)[,1])
numActivities  = length(activities[,1])
numCols        = dim(cleaned)[2]
result         = cleaned[1:(numSubjects*numActivities), ]


#iterate on the data
row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = activities[a, 2]
    tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}

#write the data to text file
write.table(result, "data_set_with_the_averages_with_rowname_false.txt", row.name=FALSE)
