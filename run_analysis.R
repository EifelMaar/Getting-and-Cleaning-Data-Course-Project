## This script does following: 
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement.
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names.
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## check for dependencies (packages) and install them if necessary

if (!require(data.table))
{
  install.packages("data.table")
  if (!require(data.table)) { return("No DT package")}
}
if (!require(reshape2))
{
  install.packages("reshape2")
  if (!require(reshape2)) { return("No reshape2 package")}
}


## Loading/Reading
# the activity labels
df_ActivityLabels <- read.table("./PA3/UCI HAR Dataset/activity_labels.txt")
df_ActivityLabels[,2] <- as.character(df_ActivityLabels[,2])

# the features
df_features <- read.table("./PA3/UCI HAR Dataset/features.txt")

# the training data
df_X_train <- read.table("./PA3/UCI HAR Dataset/train/X_train.txt")
df_y_train <- read.table("./PA3/UCI HAR Dataset/train/y_train.txt")
df_s_train <- read.table("./PA3/UCI HAR Dataset/train/subject_train.txt")

# the test data
df_X_test <- read.table("./PA3/UCI HAR Dataset/test/X_test.txt")
df_y_test <- read.table("./PA3/UCI HAR Dataset/test/y_test.txt")
df_s_test <- read.table("./PA3/UCI HAR Dataset/test/subject_test.txt")

## merge data
dataSet_x <- rbind(df_X_train,df_X_test)
subject_s <- rbind(df_s_train, df_s_test)
names(subject_s) <- 'subject'
activity_y <- rbind(df_y_train, df_y_test)
names(activity_y) <- 'activity'

## Extract relevant data
# Filter and create a vector of only mean and standard deviation
vec_MeanStdPattern <- grep("-(mean()|std()).*", as.character(df_features[,2])) 
dataSet_x <- dataSet_x[,vec_MeanStdPattern]

vec_ColNames <- df_features[vec_MeanStdPattern, 2]
vec_ColNames <- gsub("-mean", "Mean", vec_ColNames)
vec_ColNames <- gsub("-std", "Std", vec_ColNames)
vec_ColNames <- gsub("[-()]", "", vec_ColNames)


## Merge all
final_dataSet <- cbind(subject_s,activity_y, dataSet_x)
colnames(final_dataSet) <- c("subject", "activity", vec_ColNames)

# order the activity column of dataSet, replace lable of levels with activity_levels, and apply it to the final dataSet.
#order <- factor(final_dataSet$activity)
levels(order) <- df_ActivityLabels[,2]
final_dataSet$activity <- order
final_dataSet$subject <- as.factor(final_dataSet$subject)

#final_dataSet$activtiy <- factor(final_dataSet$activity, levels = df_ActivityLabels[,1], labels[,2])
#final_dataSet&subject <- as.factor(final_dataSet$subject)

# create tidy data set
baseData <- melt(final_dataSet,(id.vars=c("subject","activity")))
tidyDataSet <- dcast(baseData, subject + activity ~ variable, mean)
write.table(tidyDataSet, "./PA3/tidy_data.csv", sep = ";")
