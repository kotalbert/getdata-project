==================================================================
Getting and Cleaning Data, course project
Pawel Daniluk
Version 1.0, 2016-10-16
==================================================================

This project is to demonstrate basic R techniques for data manipulation and analysis.
For the purpose of this project, data for smartphone movement recognition experiment was used [1].
Original smartphone experiment data was provided as a collection of text files,
with variable names and observation indices stored separately. In addition,
dataset was separated into training and test samples.

As part of assignment, both training and test sets were to be combined. Each variable were to be given appropriate and descriptive name. Finally, data set was to be aggregated into "tidy" data by calculating mean of each variable over grouping columns (subject and activity).

The column names were extracted from the 'features.txt' file. The position of the name in the file corresponds to index of the column in both train and test sets.
Similarly, test subject id were stored in 'subject_test.txt' and 'subject_train.txt' files, each row id corresponding to the row of the respective data set.

Project dataset contents:
======================================

- 'README.txt'

- 'run_analysis.R' : R script, accomplishing all the required data transformation and analysis 

- 'tidy_set.txt' : "tidy" output data, transformed from the input data files 

- 'tidy_set_info.txt' : Information about variables in the output data set

Files used from the original dataset:
======================================

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'train/subject_train.txt' : Subject id for training set.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'test/subject_test.txt' : Subject id for test set.

Reference:
========

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
