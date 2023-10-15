library(dplyr)

#Extracting all the data from given dataset [UCI HAR Dataset]
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Merging training and test sets to create one data set
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
mergedData <- cbind(subject, x, y)

#Extracting only the measurements on the mean and standard deviation for each measurement.
tidyData <- mergedData %>% select(subject, code, contains("mean"), contains("std"))

#Naming the activities in the data set
tidyData$code <- activities[tidyData$code, 2]

#Labelling the data set with descriptive variable names. 
names(tidyData)[2] = "Activity"
names(tidyData) <- gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData) <- gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData) <- gsub("BodyBody", "Body", names(tidyData))
names(tidyData) <- gsub("Mag", "Magnitude", names(tidyData))
names(tidyData) <- gsub("^t", "Time", names(tidyData))
names(tidyData) <- gsub("^f", "Frequency", names(tidyData))
names(tidyData) <- gsub("tBody", "TimeBody", names(tidyData))
names(tidyData) <- gsub("-mean()", "Mean", names(tidyData), ignore.case = TRUE)
names(tidyData) <- gsub("-std()", "STD", names(tidyData), ignore.case = TRUE)
names(tidyData) <- gsub("-freq()", "Frequency", names(tidyData), ignore.case = TRUE)
names(tidyData) <- gsub("angle", "Angle", names(tidyData))
names(tidyData) <- gsub("gravity", "Gravity", names(tidyData))

#From tidyData, creating a second, independent tidy data set with the average of each variable for each activity and each subject.
finalData <- tidyData %>%
  group_by(subject, Activity) %>%
  summarise_all(funs(mean))
write.table(finalData, "Final Dataset.txt", row.name=FALSE)