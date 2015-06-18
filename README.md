# Getting and Cleaning Data
Getting And Cleaning Data - Course Project Assignment

This repository contains the deliverables for Coursera's Getting and Cleaning Data Course Project Assignment. 
https://class.coursera.org/getdata-015/ 

##Installation

Download and un-zip the following archive containing the data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This should result in a folder: __UCI HAR Dataset__

In the same folder download the file: __run_analysis.R__

The current directory should look something like:

* UCI HAR Dataset
    * test
        + Inertial Signals
        + subject_test.txt
	    + X_test.txt
	    + y_test.txt
    * train
	    + Inertial Signals
	    + subject_train.txt
	    + X_train.txt
	    + y_train.txt
    * activity_labels.txt
    * features.txt
    * features_info.txt
    * README.txt
* run_analysis.R

###Prerequisites:
The code is using the libraries. __*plyr*__,__*dplyr*__,__*tidyr*__

If these are not installed please install them

## The analysis (code)
More information about the data can be found in:

* CodeBook.md from this repository
* UCI HAR Dataset/README.txt file
* UCI HAR Dataset/features_info.txt file


There are 2 sets of data: test and train. They can be found in *X_test.txt and X_train.txt*. 

In each set, there are 561 variables measured. The names of the variables are in the *activity_labels.txt* file. 

The subjects for each observation can be found in *subject_train.txt and subject_test.txt* for train and test data. 

The activities for each observation can be found in *y_train.txt and y_test.txt* for train and test data. 

First we load each file.(data, subjects, actions, features and labels)

Then, we give some appropriate column names to the columns containing the subject, action, action names

We set the features as the column names of the data.

Having that, we can extract only the mean and standard deviations for each measurement as requested

Adjust a bit the column names of the data to be more descriptive. 

*    replace t by time and f by freq (frequency)
*    replace mean() or std() or meanFreq() by Mean / Std / MeanFreq
*    remove duplicate Body in some column names
*    example1: FROM: tBodyAcc-mean()-X TO: timeBodyAccMean-X
*    example2: FROM: fBodyAccMag-mean() TO: freqBodyAccMagMean

Expand the test and train data with a column indicating the source of the data (test or train)

Add the column containing the subjects to each data

Add the column containing the activity name to each data. (this column was built by joining the actions with the activity labels). 

Now, each data (test and train) contain descriptive column names, the subject, the activity name and the source.
It is time to merge them. The result is stored in a variable __tidyData__. 

Once data is merged, we need to group it by subject and action into __by_subject_action__ variable 
And the average for each measurement will be calculated. The column *source* will be excluded in this step because this level of detail is not necessary.

Finally the data is written to a text file: __output.txt__

## Run the analysis

* Set your working directory to the folder where the run_analysis.R file is.
* In R run: __source("run_analysis.R")__
* The result should be a file __output.txt__ in your working directory.


