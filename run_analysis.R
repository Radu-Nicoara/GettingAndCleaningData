
# load the necessary libraries
library(plyr); 
library(dplyr)
library(tidyr)

# Load the data. 
# Assumption: the downloaded zip file was extracted in the current directory resulting a folder: UCI HAR Dataset
# The names of the data variable are self explanatory of what is loaded

actionLabels<-read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)
features<-unlist(read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)[2],use.names=FALSE)

testSubjects<-read.table("./UCI HAR Dataset/test/subject_test.txt",stringsAsFactors = FALSE)
testActions<-read.table("./UCI HAR Dataset/test/y_test.txt",stringsAsFactors = FALSE)
testData<-read.table("./UCI HAR Dataset/test/X_test.txt",stringsAsFactors = FALSE)

trainSubjects<-read.table("./UCI HAR Dataset/train/subject_train.txt",stringsAsFactors = FALSE)
trainActions<-read.table("./UCI HAR Dataset/train/y_train.txt",stringsAsFactors = FALSE)
trainData<-read.table("./UCI HAR Dataset/train/X_train.txt",stringsAsFactors = FALSE)


# Set-up proper column names for the Actions, Subjects, Labels
colnames(testActions) <- c("actionId")
colnames(testSubjects) <- c("subjectId")
colnames(trainActions) <- c("actionId")
colnames(trainSubjects) <- c("subjectId")
colnames(actionLabels) <- c("actionId","action")

# Set the fuatures as column names for test and train data
colnames(testData) <- features
colnames(trainData) <- features

# Extract only the measurements on the mean and standard deviation for each measurement 
selectedTestData <- testData[grep("mean|std",features)]
selectedTrainData <- trainData[grep("mean|std",features)]

# Make the column names more descriptive.
# - replace t by time and f by freq (frequency)
# - replace mean() or std() or meanFreq() by Mean / Std / MeanFreq
# - remove dupplicate Body in some column names
# example1: FROM: tBodyAcc-mean()-X TO: timeBodyAccMean-X
# example2: FROM: fBodyAccMag-mean() TO: freqBodyAccMagMean
colnames<-colnames(selectedTestData)

colnames<-gsub("*-mean\\(\\)*","Mean",colnames)
colnames<-gsub("*-meanFreq\\(\\)*","MeanFreq",colnames)
colnames<-gsub("*-std\\(\\)*","Std",colnames)
colnames<-sub("^t","time",colnames)
colnames<-sub("^f","freq",colnames)
colnames<-sub("BodyBody","Body",colnames)

# set the nicer column names for the test and train selected data
colnames(selectedTestData)<-colnames
colnames(selectedTrainData)<-colnames

# Add a column in order to know whether is a tran or test data
selectedTrainData<-mutate(selectedTrainData,source="train")
selectedTestData<-mutate(selectedTestData,source="test")

# Add the subjects to the data belongs to
selectedTestData<-bind_cols(selectedTestData,testSubjects)
selectedTrainData<-bind_cols(selectedTrainData,trainSubjects)

# Add descriptive activity names to each data
# First it was necessary to give a name to the test/train activities(actions). 
# This was done by joining the actionLabels with tyest/train Actions
selectedTestData<-bind_cols(selectedTestData,join(actionLabels,testActions,by="actionId")[2])
selectedTrainData<-bind_cols(selectedTrainData,join(actionLabels,trainActions,by="actionId")[2])

# once test and train data are set up, we are ready to merge them
tidyData<-bind_rows(selectedTestData,selectedTrainData)

# prepare step 5 of the assignment
# group data by subject and action
by_subject_action <- tidyData %>% group_by(subjectId,action) 
# calculate the average of each variable for each activity and each subject
# the column source was not selected because that information was not relevant in this specific step
by_subject_action<-by_subject_action %>% summarise_each(funs(mean(.,na.rm=TRUE)),-source)
# order the data
by_subject_action<-arrange(by_subject_action,subjectId,action)
# create the output file
write.table(by_subject_action,"output.txt",row.names=FALSE)

