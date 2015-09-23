library(dplyr)

## Ensure that the required files exist.
if (!file.exists("test/X_test.txt") |
    !file.exists("test/y_test.txt") |
    !file.exists("test/subject_test.txt") |
    !file.exists("train/X_train.txt") |
    !file.exists("train/y_train.txt") |
    !file.exists("train/subject_train.txt") |
    !file.exists("features.txt") |
    !file.exists("activity_labels.txt") 
    ){	
    stop("Please ensure to run this script in the same directory as Samsung Data folder and that all files are there!") 
}

## 1- Merge train set with the test set
completeSet <- read.table("train/X_train.txt") %>% bind_rows(read.table("test/X_test.txt"))

## 2- Extracts only the measurements on the mean and standard deviation for each measurement
# Identify variable indices for mean and std
features <- read.table("features.txt")
mean_std_variables <- features[grep(".*(mean|std).*", features$V2) , ]
# select variables/columns dealing with mean or standard deviation for each measure
completeSet_mean_std <- select(completeSet, mean_std_variables$V1)

## 3- Uses descriptive activity names to name the activities in the data set
activities <- read.table("train/Y_train.txt") %>% bind_rows(read.table("test/Y_test.txt"))
activity_Type <- read.table("activity_labels.txt")
# replace the activity number by its name
activities <- mutate(activities, V1 = activity_Type[V1, "V2"])
completeSet_mean_std <- bind_cols(activities, completeSet_mean_std)

## 4- Appropriately labels the data set with descriptive variable names.
names(completeSet_mean_std) <- c("activity", as.character(mean_std_variables$V2))

## 5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- read.table("train/subject_train.txt", col.names = "subject") %>% 
                bind_rows(read.table("test/subject_test.txt", col.names = "subject")) %>%
                bind_cols(completeSet_mean_std) %>%
                group_by(subject, activity) %>%
                summarise_each(funs(mean))

write.table(x = tidy_data, file = "tidyData.txt", row.names = FALSE)
