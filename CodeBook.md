Code Book
==========

## 1. Check for dependencies (packages) and install them if necessary
This script will check if the data file is present in your working directory. (If not, will download and unzip the file)

## 2. Loading/Reading the data files

* df_ActivityLabels : Description of activity IDs in y_test and y_train
* df_X_train : values of variables in train
* df_y_train : activity ID in train
* df_s_train  : subject IDs for train
* df_X_test : values of variables in test
* df_y_test : activity ID in test
* df_s_test : subject IDs for test
* df_features : description(label) of each variables in X_test and X_train

## 2. Merge data

* dataSet_x : bind of df_X_train and df_X_test
* subject_s : bind of df_s_train and df_s_test
* activity_y : bind of df_y_train and df_y_test

## 3. Extract relevant data

* dataSet_x : at the end of this step, dataSet will only contain mean and std variables

## 4. Changing Column label of dataSet

## 5. Merge all
Combine test data and train data of subject and activity, then give descriptive lables. Finally, bind with dataSet. At the end of this step, dataSet has 2 additonal columns 'subject' and 'activity' in the left side.
* final_dataSet : bind of subject_s,  activity_y and dataSet_x

## 6. Rename ID to activity name
Group the activity column of dataSet as "act_group", then rename each levels with 2nd column of activity_levels. Finally apply the renamed "act_group" to dataSet's activity column.
* act_group : factored activity column of dataSet 

## 7. Output tidy data
In this part, dataSet is melted to create tidy data. Finally output the data as "tidy_data.csv"
* baseData : melted tall and skinny dataSet
* tidyDataSet : casete baseData which has means of each variables
