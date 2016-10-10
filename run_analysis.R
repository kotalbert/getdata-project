# This program was created for the Getting and Cleaning Data course project
# The program:
# Downloads the files from the Internet to be used in further operations
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Download and unzip the files into /data catalogue.
# This part of program can be used to perform analysis from scratch
# If the zip file is not already in ./data folder

if (!file.exists("./data")) dir.create("./data")

u <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zfile <- "./data/data.zip"
download.file(u, zfile)
unzip(zfile, exdir="./data")

# Read data into data frames for transformations and merging
file_path <- function(fname) {
  # Function for creating path to files
  fold <- "./data/UCI HAR Dataset/"
  return (paste0(fold, fname))
}

# List of features
features <- read.table(file_path("features.txt"))

# training data
subject_train <- read.table(file_path("train/subject_train.txt"))
x_train <- read.table(file_path("train/X_train.txt"))
y_train <- read.table(file_path("train/y_train.txt"))

# test data
subject_test <- read.table(file_path("test/subject_test.txt"))
x_test <- read.table(file_path("test/X_test.txt"))
y_test <- read.table(file_path("test/y_test.txt"))

# Create vector of descriptive column names from features.txt
feat_names <- features$V2

# all character to lowercase
feat_names <- tolower(feat_names)

# remove all non alphanumeric characters
feat_names <- gsub("[(),-]+","", feat_names) 

# Convert activity codes into descriptive names
get_activity <- function(act_code) {
  if (act_code == 1) return("WALKING")
  else if (act_code == 2) return("WALKING_UPSTAIRS")
  else if (act_code == 3) return("WALKING_DOWNSTAIRS")
  else if (act_code == 4) return("SITTING")
  else if (act_code == 5) return("STANDING")
  else return("LAYING")
}

# Label code activities
act_label_train <- sapply(y_train[,1], get_activity)
act_label_test <- sapply(y_test[,1], get_activity)

# Merge data and labels for training and test sets
train_set <- cbind(subject_train, act_label_train, x_train)
test_set <- cbind(subject_test, act_label_test, x_test)

# rename variables in training and test dataframes
colnames(train_set) <- c("subjectid", "activity", feat_names)
colnames(test_set) <- c("subjectid", "activity", feat_names)

# Join training and test sets into one set
full_set <- rbind(train_set, test_set)

# Select only the measurements of mean and standard deviation
# Using grep function to get indices of columns containing "mean" or "std"
# literals, as described in features_info.txt. Retain subject id and activity 
# label

col_indx <- c(1,2, grep("mean|std", colnames(full_set)))

# Data set, required in point 4. of the assignment, to be converted into tidy
# data set
avg_std_set <- full_set[, col_indx]

# Calculate required statistics: average of each variable over each activity
# and each each subject, using dplyr package and chain operator %>%
# summarize_all function allows to apply aggregating function to all non-group
# columns in data set. Since all variables are averages, there is no need to 
# change names of the variables in output data set

library(dplyr)
tidy_set <- avg_std_set %>% tbl_df %>%
  group_by(subjectid, activity) %>%
  summarize_all(mean)

# Write tidy data into a separate file
write.table(tidy_set, "./tidy_set.txt", row.names = F)
