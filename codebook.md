## Raw data summary 
The raw data can be downloaded at the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Once extracted, the folders contain various text files that contain data by Samsung on triaxial accelerometers and gyroscope readings during different common daily motion actiivities.  The data is randomly separated into test and training groups for comparative research.  Important labeling and README data can be found at the top of the directory.  Test and training sub-datasets can be found in the folders "Test" and "train".  Each of these folders contains data in "inertial signals" which consists of the raw input data, while the test and train datasets contains its summary data.  The run_analysis() function only extracts specific summary data, and so the inertial signals will not be extracted or modified. 

### X_test and X_train
These datasets contain several 'untidy' summary data for each subject over  561 variables (labels for which are found in 'features').  

2947 observations are in test, and 7352 observations are in train.  

### y_test and y_train
These datasets contain the recorded categorical variables for 6 motion activities for each row of the datasets 'test' and 'train.'The values are coded numerically, the key for which can be found in the text file "activity_labels"

### subject_test and subject_train
These datasets contain the ID number for all the subjects in the test and train trial groups.  Each subject was given an ID between 1 and 30.  

### activity_labels
The key for coding categorical variables of y_test and y_train.  There are 6 activities labels from one to six:  Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying

### features
The names of all 561 variables for the datasets X_test and X_train.  

## Reading Data
R code for reading data is labeled under 'Step 1' in the comments.  Using the more efficient fread() function from the 'data.table' package, the text files are read in and are assigned variable values analogous to their file name.  Within the fread() function, the file location is created using file.path(), passing arguments
dir (from run_analysis), and the file location relative to the dataset folder.  

## Transforming Data

### Combining activity labels and recoding to character values
The variable 'y' is created which combines the coded categorical data from both the y_test and y_train datasets, using the rbind() function.  To make the data more descriptive, the mapvalues() function from the plyr package is used to replace the numeric values of y to their corresponding variables keyed by "activity_labels".  The resulting value is re-converted to a single column data frame, and is afterwards assigned the column name "activity labels"

### Transposing features
Features data is converted from 561 rows to 561 columns using the t() function, to prepare it for naming the columns of the Master dataset 

### Combining Subject data
The data frame 'subject' is created which combines the subject_test and subject_train data, using the rbind() function.  The column name is assigned as "Subject"

### Creating "Group" column
To identify which records are from the test and train groups, a data frame called 'group' is created with a single column is created repeating the strings "test" and "train" for the number of rows of each corresponding dataset.  The column name is assigned as "Group"

## Assembling Master data

### Creating data, naming and selecting columns
The data frame 'Master' is created by combining the datasets X_test and X_train.  The features data is applied to the Master data as the column names.  The variable "keep" calculates which columns have and mean and standard deviation data.  It does so by using the grepl() function to index which column names contain the string patterns "mean()" and "std()" in the column names, and the select() function (dplyr package) is applied to keep the columns of Master according to the "keep" index.  

### Adding columns, Finished Master data
Using the cbind() function, the single column data frames 'subject,' 'group,' and 'y' are combined to "Master" data.  The Master data is complete!

## Create final data, and write txt file

### Create "Tidy" data
Using the %>% pipe operator, group_by() and summarise_each() functions from the dplyr package, the Master data is grouped by 'subject' ID and averaged for each variable with the mean() function.

### Write .txt file
The file is written with write.table() and writes the file in the current working directory.  

