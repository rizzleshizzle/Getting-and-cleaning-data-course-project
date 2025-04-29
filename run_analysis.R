## Set working directory

## Load packages
library(dplyr)

## Read in features and activity labels 
features <- read.table("features.txt", col.names = c("index", "feature"))
activities <- read.table("activity_labels.txt", col.names = c("code", "activity"))

# Read training data
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

## Read test data
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

## Merge the training and test data
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)

## Name the columns
colnames(X) <- features$feature
colnames(Y) <- "Activity"
colnames(Subject) <- "Subject"

## Combine into one full dataset
full_data <- cbind(Subject, Y, X)

## Extract only the mean and sd measurements
mean_std_columns <- grepl("mean\\(\\)|std\\(\\)", features$feature)
data_mean_std <- full_data[, c(TRUE, TRUE, mean_std_columns)]

## Use descriptive activity means 
data_mean_std$Activity <- factor(data_mean_std$Activity,
                                 levels = activities$code,
                                 labels = activities$activity)

## Label the dataset with descriptive variable names
names(data_mean_std) <- gsub("^t", "Time", names(data_mean_std))
names(data_mean_std) <- gsub("^f", "Frequency", names(data_mean_std))
names(data_mean_std) <- gsub("Acc", "Accelerometer", names(data_mean_std))
names(data_mean_std) <- gsub("Gyro", "Gyroscope", names(data_mean_std))
names(data_mean_std) <- gsub("Mag", "Magnitude", names(data_mean_std))
names(data_mean_std) <- gsub("BodyBody", "Body", names(data_mean_std))
names(data_mean_std) <- gsub("-mean\\(\\)", "Mean", names(data_mean_std))
names(data_mean_std) <- gsub("-std\\(\\)", "STD", names(data_mean_std))
names(data_mean_std) <- gsub("-", "", names(data_mean_std))

## Create second tidy dataset with averages for each activity and subject
tidy_data <- data_mean_std %>%
  group_by(Subject, Activity) %>%
  summarise_all(mean)

## Write tidy dataset to file
write.table(tidy_data, "tidy_dataset.txt", row.names = FALSE)
