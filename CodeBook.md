The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

1.Download the data set
Data set downloaded and extracted under the folder called UCI HAR Dataset

2.Assign each data to variables
features <- features.txt : 561 obs. of 2 variables
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
activities <- activity_labels.txt : 6 obs. of 2 variables
List of activities performed when the corresponding measurements were taken and its codes (labels)
subject_test <- test/subject_test.txt : 2947 obs. of 1 column
contains test data of 9/30 volunteer test subjects being observed
x_test <- test/X_test.txt : 2947 obs. of 561 columns
contains recorded features test data
y_test <- test/y_test.txt : 2947 obs. of 1 columns
contains test data of activities’ code labels
subject_train <- test/subject_train.txt : 7352 obs. of 1 column
contains train data of 21/30 volunteer subjects being observed
x_train <- test/X_train.txt : 7352 obs. of 561 columns
contains recorded features train data
y_train <- test/y_train.txt : 7352 obs. of 1 columns
contains train data of activities’ code labels

3.Merges the training and the test sets to create one data set
x (10299 obs. of 561 variables) is created by merging x_train and x_test using rbind() function
y (10299 obs. of 1 variable) is created by merging y_train and y_test using rbind() function
subject (10299 obs. of 1 variable) is created by merging subject_train and subject_test using rbind() function
mergedData (10299 obs. of 563 variables) is created by merging Subject, Y and X using cbind() function

4.Extracts only the measurements on the mean and standard deviation for each measurement
tidyData (10299 obs. of 88 variables) is created by subsetting mergedData, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

5.Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the tidyData replaced with corresponding activity taken from second column of the activities variable

6.Appropriately labels the data set with descriptive variable names
code column in tidyData renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time
All tBody in column's name replaced by TimeBody
All -mean() in column's name replaced by Mean
All -std() in column's name replaced by STD
All -freq() in column's name replaced by Frequency

7.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
finalData (180 obs. of 88 variables) is created by summarizing tidyData taking the means of each variable for each activity and each subject, after being grouped by subject and Activity.
Export finalData into Final Dataset.txt file.