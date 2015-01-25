# Getting-and-Cleaning-Data
Used for the Coursera Getting and Cleaning Data Course <br/>
The data all of used for all of this originally came from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


There are three files in the the Getting-and-Cleaning-Data repository.

## README.md
  Which explains all the files included in the repository
  
## CodeBook.md
 Used to understand how the code manipulates and changes the initial data

## run_analysis.R
  Documented code used to solve the homework assignment for the Coursera course on Getting and Cleaning Data
  It completes the following steps  and ultimately writes a tidy data table into your working directory.
  * 1.Merges the training and the test sets to create one data set.
  * 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
  * 3.Uses descriptive activity names to name the activities in the data set
  * 4.Appropriately labels the data set with descriptive variable names. 
  * 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. <br/>
  This code is run from a working directory inside the initial unzipped folder location (\getdata-projectfiles-UCI HAR Dataset)<br/>
  Necessary packages include:
  * dplyr
  * reshape2

