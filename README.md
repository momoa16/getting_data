## ===== Getting and Cleaning Data Course Project ====
### Objectives
The objective of this project is to demonstrate the ability to manipulate data. Manipulation involves selecting columns, filtering rows, merging files, rows, columns, and finally transforming data.

## Work Description
As run_analysis.R script shoud be executed in the same directory as the Samsung data of this project unzipped, I start the script by checking that the required files exist. Then the project task are performed as follows:

* Task 1: To merge the training and the test sets to create one data set. The result is stored in the data frame called *completeSet*.
* Task 2: To Extract only the measurements on the mean and standard deviation for each measurement. As variable names are stored in *features.txt*, this file is loaded into a data frame called *features*. The features dealing with means and standard deviations are searched using grep and the result is stored in *mean_std_variables*. mean_std_variables is used as index to *select* to extract the columns representing only mean and std. The result is stored in *completeSet_mean_std*. 
* Task 3: To use descriptive activity names to name the activities in the data set. I started by merging and loading training and test activities in one data frame *activities*. Then using the *activity_labels.txt* I changed the activities numbers by categorical names. Finally, the result is added to *completeSet_mean_std* as a new column.
* Task 4: Appropriately labels the data set with descriptive variable names. *mean_std_variables* calculated in task 2 is used to label columns with informative names
* Task 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. First the subject numbers are merged, loaded, added to *completeSet_mean_std* as a new column, grouped by *subject* and *activity* to be finally summarized by mean function over all the columns using *summarise_each*.
