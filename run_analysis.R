## RUN_ANALYSIS

## 0. LOAD LIBRARIES

library(plyr)
library(dplyr)

## 1. MERGE TRAINING AND TEST SET

## Load and merge test data
X_test<-read.table("test/X_test.txt")
Y_test<-read.table("test/Y_test.txt")
subject_test<-read.table("test/subject_test.txt")
test<-cbind(subject_test,Y_test,X_test)

## Load and merge training data
X_train<-read.table("train/X_train.txt")
Y_train<-read.table("train/Y_train.txt")
subject_train<-read.table("train/subject_train.txt")
train<-cbind(subject_train,Y_train,X_train)

## Merge training and test data
acc<-rbind(train,test)


## 2. EXTRACT MEASUREMENTS ON THE MEAN AND ST.DEV

## Insert column names
## Because of the way the data was merged the first column is "subject"
## The second column is "activity"
## And from the third column on the names are as in the features table
features<-read.table("features.txt")
features[,2]<-as.character(features[,2])
colnames(acc)<-c("subject","activity",features[,2])

##Create a data frame withour duplicate columns
## Some columns have duplicate names and this complicates operations on the table
## Non of these duplicate columns will be used in the rest of the exercise
## So we can create a data frame without the duplicate columns
accnd <- acc[, !duplicated(colnames(acc))]
sum(duplicated(colnames(accnd)))

## Extract measurements on the mean and the st.dev

##Only measurements containing "mean()" or "std()" are actually means or st.dev
##Measurements containing "mean" or "std" without brackets are calculations on the mean or st.dev
accms<-select(accnd,subject,activity,contains("mean()"),contains("std()"))


## 3. USE DESCRIPTIVE ACTIVITY NAMES

## Replace numbers with corresponding activity name from activity_labels table
al<-read.table("activity_labels.txt")
accms$activity<-gsub(1,al[1,2],accms$activity)
accms$activity<-gsub(2,al[2,2],accms$activity)
accms$activity<-gsub(3,al[3,2],accms$activity)
accms$activity<-gsub(4,al[4,2],accms$activity)
accms$activity<-gsub(5,al[5,2],accms$activity)
accms$activity<-gsub(6,al[6,2],accms$activity)

## 4. USE DESCRIPTIVE VARIABLE NAMES

## This has already been done in step two, replacing the colums names by
## "subject","activity", and the names from the features table


## 5. CREATE DATA SET WITH AVERAGE FOR EACH ACTIVITY AND SUBJECT

newdf<-ddply(accms, .(subject,activity), colwise(mean))
colnames(newdf) <- paste("mean", colnames(newdf), sep = "-")
colnames(newdf)[1] <- "subject"
colnames(newdf)[2] <- "activity"
View(newdf)
