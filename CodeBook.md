#Code Book

This code book describes the data used for this assigment as well as any transformations were done on it. 

## Original data
The raw data is the data available for download and described in details at this location:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#
Also some extra information about the data can be found in the files:

* UCI HAR Dataset/README.txt file
* UCI HAR Dataset/features_info.txt file

Further we will concentrate on the transformations done on the data. 

## Transformations
The data, Subjects, Actions, ActivityLabels data had not column names.

Thus first step in tidying the data is to add some column names.

* for subjects data: subjectId
* for actions data: actionId
* for action labels: actionId and action
* for data: the data contained in the features.txt file actually represents the measurables. Thus, we put the features as column names.

As requested, not all the measurables are necessary in this assignment. Thus we created a subset of each data: *selectedTestData* and *selectedTrainData* containing only the mean and standard deviation for the measurables. These were identified by the naming convention: mean()/meanFreq() and std()

Still, the names of the measurables can be made a bit more descriptive. This was done by following transformations:

*    replace t by time and f by freq (frequency)
*    replace mean() or std() or meanFreq() by Mean / Std / MeanFreq
*    remove duplicate Body in some column names
*    example1: FROM: __tBodyAcc-mean()-X__ TO: __timeBodyAccMean-X__
*    example2: FROM: __fBodyAccMag-mean()__ TO: __freqBodyAccMagMean__

To have a tidy data, we do need to add some details to the measurables. These details are: 

* __source__ : is it test or train data
* __subject__: the subject who did the observation
* __action__: the action performed by the subject when the observation was done. In this case we will add the __action name__ instead of *actionId*. Therefore we will transform the id's in names by joining with the data contained in actionLabels(*activity_labels.txt*)

Once this data was added, *selectedTestData* and *selectedTrainData* are tidy. Besides the measurables that have now a more descriptive name, also information about the source, the subject and the action was added.

*selectedTestData* and *selectedTrainData* are merged in one data source: __tidyData__.

Final step in this assigments, requires groupping the data by subject and action regardless the source (test or train). Thus for the next stepts we will exclude the source column. 

__tidyData__ is groupped by subject and action,  the result is stored in __by_subject_action__ variable and for each measurable the mean is calculated. 

Finally, the __by_subject_action__ is written to a text file: __output.txt__

