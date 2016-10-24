#1. Merges the training and the test sets to create one data set.
##step1. download zipfile from website and unzip data
if(!file.exists("./data")) dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/getandcleandata.zip")
unzipdata <- unzip("./data/getandcleandata.zip", exdir = "./data")
##step2. load data into R
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
##step3. merge train and test data
train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)
tdata <- rbind(train, test)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##step1. load feature name into R
featurename <- read.table("./data/UCI HAR Dataset/features.txt")[, 2]
##step2. extract mean and std of each measurement
featureindex <- grep("mean\\(\\)|std\\(\\)", featurename)
fdata <- tdata[, c(1, 2, featureindex+2)]
colnames(fdata) <- c("subject", "activity", as.character(featurename[featureindex]))

#3. Uses descriptive activity names to name the activities in the data set. 
##step1. load activity names into R
activityname <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
##step2. replace number with activity names
fdata$activity <- factor(fdata$activity, levels = activityname[, 1], labels = activityname[, 2])

#4. Appropriately labels the data set with descriptive variable names. 
names(fdata) <- gsub("\\()", "", names(fdata))
names(fdata) <- gsub("^t", "time", names(fdata))
names(fdata) <- gsub("^f", "frequency", names(fdata))
names(fdata) <- gsub("-mean", "Mean", names(fdata))
names(fdata) <- gsub("-std", "Std", names(fdata))

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
tidydata <- fdata %>%
        group_by(subject, activity) %>%
        summarize_each(funs(mean))

if(!file.exists("./Getting_And_Cleaning_Data")) dir.create("./Getting_And_Cleaning_Data")
write.table(tidydata, "./Getting_And_Cleaning_Data/Mean.txt", row.names = FALSE)