##run_analysis.R

This cookbook explains the steps taken to convert the raw data from UCIHARDataset.zip and
convert it to the tidy data table tidymean.txt. The working directory should be set to the
directory where the UCIHARDataset.zip is unzipped.


## 0. LOAD LIBRARIES
Before we start we load the libraries "plyr" and "dplyr" which we´ll need later on.

## 1. MERGE TRAINING AND TEST SET
The first step is to load the data files for the test set (test/X_test.txt, test/Y_test.txt, 
test/subject_test.txt). and combine them in that same order in to one data frame (test) with "cbind".

The next step is to load the data files for the train set (test/X_train.txt, test/Y_train.txt, 
test/subject_train.txt). and combine them in that same order in to one data frame (train) with "cbind".

Then we can merge "test" and "train" in to a new data frame (acc) with "rbind".

## 2. EXTRACT MEASUREMENTS ON THE MEAN AND ST.DEV
The second step is to extract measurements on the mean and standard deviation.

But before we can do this we need to give the columns their corresponding names.
Because of the way the data was merged the first column is "subject", the second column is "activity"
And from the third column on the names are as in the features table (features.txt).
We read the "features" data frame with "read.table" and assign the column names with "colnames"

Some columns have duplicate names and this complicates operations on the table
Non of these duplicate columns will be used in the rest of the exercise
So we can create a data frame without the duplicate columns (accnd) with the "duplicated" function.

Now we can finally extract measurements on the mean and the st.dev
We should take into account that only measurements containing "mean()" or "std()" are actually means or st.devs
Measurements containing "mean" or "std" without brackets are calculations on the mean or st.dev
We make a new data frame (accms) with only the measurements on the mean and st.dev using the select function

## 3. USE DESCRIPTIVE ACTIVITY NAMES
The third step is to use descriptive activity names to make the data more readable.
We do this by replacing the activity numbers by the corresponding activity names from the
activity labels table (activity_labels.txt).
We read the "features" data frame with "read.table" and replace the activity numbers with
activity names using the "gsub" function.

## 4. USE DESCRIPTIVE VARIABLE NAMES
This has already been done as part of step two, replacing the colums names by "subject","activity",
and the names from the features table.


## 5. CREATE DATA SET WITH AVERAGE FOR EACH ACTIVITY AND SUBJECT
The last step is to create a tidy data set (newdf) with the average for each activity and subject.
We do this using the ddply function on the accms data set.

Finally we give the new data set the correct column namens with the "colnames" function and
take a look at the new tidy data set with "View".


