# Create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Load packages
library(data.table)
library(reshape2)

# Read activity_labels.txt as a data table and assign to a varibale called activityLbl
activityLbl <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Read features.txt as a data table and assiggn to a variable called features
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

### TEST DATA

# Read X_test.txt as a data table and assign to a variable called xTest
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")

# Read y_test.txt as a data table and assign to a variable called yTest
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")

# Read subject_test.txt as a data table and assign to a variable called subjectTest
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Assign names to xTest data using data from features variable
names(xTest) <- features

# Create a logical vector matching the mean and standard deviation for each measurement from features variable.
logicalMatchVector <- grepl("mean|std", features)

# Get the mean and standard deviation for each measurement from xTest.  Assign to xTest.  We are not interested in the rest of xTest values.
xTest = xTest[,logicalMatchVector]

# Add a new column to yTest for the description of the activity
yTest[,2] = activityLbl[yTest[,1]]

# Name the columns of yTest as 'ActivityId' and 'ActivityDescription'
names(yTest) = c("ActivityId", "ActivityDescription")

# Name the column in subjectTest 'Subject'
names(subjectTest) = "Subject"

# Combine by column subjectTest, yTest, and xTest
testData <- cbind(as.data.table(subjectTest), yTest, xTest)

### TRAIN DATA

# Read X_train.txt as a data table and assign to a variable called xTrain
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")

# Read y_train.txt as a data table and assign to a variable called yTrain
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

# Read subject_train.txt as a data table and assign to a variable called subjectTrain
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Assign names to xTest data using data from features variable; the same way we did with test
names(xTrain) = features

# Get the mean and standard deviation for each measurement from xTrain.  Assign to xTrain.
xTrain = xTrain[,logicalMatchVector]

# Add a new column to yTrain with the descriotion of the correspondent activity
yTrain[,2] = activityLbl[yTrain[,1]]

# Name the columns of yTrain as 'ActivityId' and 'ActivityDescription'
names(yTrain) = c("ActivityId", "ActivityDescription")

# Name the column in subjectTrain 'Subject'
names(subjectTrain) = "Subject"

# Combine by column subjectTrain, yTrain, and xTrain
trainData <- cbind(as.data.table(subjectTrain), yTrain, xTrain)

# Combine test and train data by row
allData = rbind(testData, trainData)

# Reshape allData so the measurements are in one column and ordered by Subject, ActivityId, and ActivityDescription
reshapedData = melt(allData, id = c("Subject", "ActivityId", "ActivityDescription"), measure.vars = setdiff(colnames(allData),c("Subject", "ActivityId", "ActivityDescription")))

# Reshape into a dataframe using dcast and the formula Subject + ActivityDescription ~ variable; use mean to agregate data before casting
tidyData   = dcast(reshapedData, Subject + ActivityDescription ~ variable, mean)

# Save tidyData to a file called tidy_data.txt
write.table(tidyData, file = "tidy_data.txt", sep="\t")