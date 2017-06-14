Getting and Cleaning Data - Tidy Code Book 

This file describes the variables, the data, and any transformations or work that was performed to clean up the data


Description of the data

Experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


Input

- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training activity.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test activity.
- './UCI HAR Dataset/test/subject_test.txt': subject test


Output

tidy_data.txt


Variables

xTest - Read X_test.txt as a data table and assign to a variable called xTest
yTest - Read y_test.txt as a data table and assign to a variable called yTest
subjectTest - Read subject_test.txt as a data table and assign to a variable called subjectTest
features - Read features.txt as a data table and assiggn to a variable called features
activityLbl - Read activity_labels.txt as a data table and assign to a varibale called activityLbl
logicalMatchVector - # Create a logical vector matching the mean and standard deviation for each measurement from features variable.
testData - Combine by column subjectTest, yTest, and xTest
xTrain - Read X_train.txt as a data table and assign to a variable called xTrain
yTrain - Read y_train.txt as a data table and assign to a variable called yTrain
subjectTrain - Read subject_train.txt as a data table and assign to a variable called subjectTrain
trainData - Combine by column subjectTrain, yTrain, and xTrain
allData - Combine test and train data by row
reshapedData - Reshape allData so the measurements are in separate columns and ordered by Subject, ActivityId, and ActivityDescription
tidyData - Data that is going to be saved in a file called tidy_data.txt







