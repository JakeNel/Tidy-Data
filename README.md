# run_analysis() README

run_analysis() is a function which can be broken down into three steps.  The steps are marked in comments in the R code.  The code requires the data.table, plyr, and dplyr packages, which are loaded as part of the function.  The function works off of the raw dataset created by downloading and extracting the data from this url on your computer:  

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The function assumes that the raw dataset exists on the computer at location 'dir', an argument which is the current working directory by default.  

## Step 1  Reading the Data
The code uses the fread() function (data.table package) to read in the text files for each of the relevant text files in the UCI HAR dataset.  The function finds this dataset based on the 'dir' argument it is passed.

## Step 2 Modifying Variables
Step 2 modifies parts of the data to get ready for final complilation.  The work involves combining data sets, naming columns, recoding categorical variables, sorting, and adding subjects IDs.

## Step 3 Creating the Master Dataset
A Master dataset is created by which the Tidy dataset is derived.  

## Step 4 Creating and Writing Final "Tidy" Dataset
The Master dataset is the clean combination of the test and training datasets.  From the master data set, it takes the mean of each variable for each subject, creating the final "tidy"  dataset.

The Tidy data set is written as a text file in the current directory, under the name "Tidy.txt"  

