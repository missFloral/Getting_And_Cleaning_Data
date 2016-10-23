Codebook for the tidy dataset
=============================

Data Source
-----------
The dataset being used is: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Major steps
-----------
The script `run_analysis.R`performs the 5 steps described in the course project's definition.

* Use `read.tables()` `cbind()` `rbind()` to merge the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set through `factor()` function
* Appropriately labels the data set with descriptive variable names by using `gsub()` function. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject, with the help of dplyr package.

Variable
--------

* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `train`, `test` and `tdata` merge the previous datasets to further analysis.
* `featurename` contains the correct names for the `fdata` dataset, which are applied to the column numbers stored in `featureindex`, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the `activities` variable.



