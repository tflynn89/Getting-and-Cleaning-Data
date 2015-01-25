#run_analysis.R

## Required packages: reshape2, dplyr 

##This file will appease all of the parts of the assignment but in a different order
##As I was going through I felt I shoudl take certain steps when they made sense or were easier to test
##I will do my best to call out the steps as they are completed.


##Readin in all of the files used individually
xTest<-read.table("UCI HAR Dataset/test/X_test.txt")

yTest<-read.table("UCI HAR Dataset/test/y_test.txt")

subTest<-read.table("UCI HAR Dataset/test/subject_test.txt")

Activities <-read.table("UCI HAR Dataset/activity_labels.txt")

Features <-read.table("UCI HAR Dataset/features.txt")

subTrain<-read.table("UCI HAR Dataset/train/subject_train.txt")

xTrain<-read.table("UCI HAR Dataset/train/X_train.txt")

yTrain<-read.table("UCI HAR Dataset/train/y_train.txt")


# Assigning the complex variable names to both x datasets
## This is essentially what  completes step 3
colnames(xTest)<-Features[,2]

colnames(xTrain)<- Features[,2]


xTest<-cbind(xTest, "source"=1) # In case I need to distinguish between test and train later column source (test =1)
xTrain<-cbind(xTrain, "source"=2)# In case I need to distinguish between test and train later column source (train =2)

## Combing my x datasets into one giant x table
AllX<- rbind(xTest,xTrain)
## Creating my variable they should combine on
AllX<-cbind(AllX, "order"=1:nrow(AllX))

## Adding my column to distinguish between test and train in the future
TestAct<-cbind(yTest, "source"=1)
TrainAct<-cbind(yTrain, "source"=2)
## Making one giant Y dataset (while maintaining the same order)
AllY<- rbind(TestAct,TrainAct)
##Creating my combining variable
AllY<-cbind(AllY, "order"=1:nrow(AllY))
## Getting the activity labels tied into the Y dataset
## This allows for step 3 to be completed at the same time as step 1
AllY<- merge(AllY,Activities)
colnames(AllY)<- c("activity_id","source","order","activity")


## Creating my giant subject step 
## Creating my source variables (1= test, 2 = train)
subTest<-cbind(subTest, "source"=1)
subTrain<-cbind(subTrain, "source"=2)
## making my giant subject file
AllSubs<- rbind(subTest,subTrain)
##creating my varuable to combine on
AllSubs<-cbind(AllSubs, "order"=1:nrow(AllSubs))
colnames(AllSubs)<- c("subject","source","order")

## Combining my giant tables together based off of their row numbers
## First subjects and Y (they were smaller so I could test)
Temp<-merge(AllSubs,AllY)
## Then the remainder
df<-merge(Temp,AllX)
####STEP 1 (Merges the training and the test sets to create one data set) COMPLETED
####STEP 3 (Uses descriptive activity names to name the activities in the data set) COMPLETED

## This was used to grab the correct variable names for the tables4
colnames(Features)<-c("position","name")

Features[,2]<-as.character(Features[,2])

## Pulling out all of the mean or std variables
measures<-data.frame(filter(Features, grepl('mean()|std()', name)))

m<-measures$position+5
m<-c(1,2,3,4,5,m)

## Creating my data frame with my variables at the star
## and the mean and STD variables 
## I actually left these as is as I don't have a good enough understanding to write great variable names
## I felt using the variable names provided and overwriting v1, v2, etc this should suffice and...
## STEP 3 (Uses descriptive activity names to name the activities in the data set) COMPLETE


newFile<-df %>%
  select(m)
###STEP 2 (Extracts only the measurements on the mean and standard deviation for each measurement) COMPLETE

##For step 5  I needed to create the second table with only the averages 
## Broke it down on subject and activity
attempt <- melt(newFile, id.vars=c("subject", "activity"))
answer<-dcast(attempt, subject + activity ~ variable, mean)
###STEP 5 (From the data set in step 4, creates a second, independent tidy data set 
###with the average of each variable for each activity and each subject.) COMPLETE

##I don't think this is actually part of step 5 but is needed for the homework so here is the write file
write.table(answer, "tidy_table.txt",row.name=FALSE)
