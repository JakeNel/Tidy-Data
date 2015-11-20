## Raw Data Summary 
The raw data can be downloaded at the following URL:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Once extracted, the folders contain various text files that contain data by Samsung on triaxial accelerometers and gyroscope readings during different common daily motion actiivities.  The data is randomly separated into test and training groups for comparative research.  Important labeling and README data can be found at the top of the directory.  Test and training sub-datasets can be found in the folders "Test" and "train".  Each of these folders contains data in "inertial signals" which consists of the raw input data, while the test and train datasets contains its summary data.  The run_analysis() function only extracts specific summary data, and so the inertial signals will not be extracted or modified. 

### X_test and X_train
These datasets contain several 'untidy' summary data for each subject over  561 variables.  See 'features' for a description of the variables and their units.  

2947 observations are in test, and 7352 observations are in train.  

### y_test and y_train
These datasets contain the recorded categorical variables for 6 motion activities for each row of the datasets 'test' and 'train.'The values are coded numerically, the key for which can be found in the text file "activity_labels"

### subject_test and subject_train
These datasets contain the ID number for all the subjects in the test and train trial groups.  Each subject was given an ID between 1 and 30.  

### activity_labels
The key for coding categorical variables of y_test and y_train.  There are 6 activities labels from one to six:  Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying

### features (variable description)
The names of all 561 variables for the datasets X_test and X_train. 

The variables measure the accelermeter and gyroscope 3 axial data over different subjects doing different activities (see 'activity_labels' and 'subjects').  Both the time domain variables (how the signal changes over time, denoted with the 't-' prefix), and frequency domain variables (how frequently the signal occurs within each frequency band).

These are the variables (where XYZ refers to 3 sub-variables of each of the 3 axial data sets).

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

From which estimating variables are calculated

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Time domain variables are measured in changes to signal per unit of time, while frequency domain variables are measured in the frequency of a signal within a unit of time.  These variables are filtered for signal noise.  

For more information, download the data and read the text file "features.info.txt"

## Reading Data
Using the more efficient fread() function from the 'data.table' package, the text files are read in and are assigned variable values analogous to their file name.  Within the fread() function, the file location is created using file.path(), passing arguments 'dir' (from run_analysis), and the file location relative to the dataset folder.  

## Transforming Data

### Combining activity labels and recoding to character values
The variable 'y' is created which combines the coded categorical data from both the y_test and y_train datasets, using the rbind() function.  To make the data more descriptive, the mapvalues() function from the plyr package is used to replace the numeric values of y to their corresponding variables keyed by "activity_labels".  The resulting value is re-converted to a single column data frame, and is afterwards assigned the column name "activity labels"

### Transposing features
Features data is converted from 561 rows to 561 columns using the t() function, to prepare it for naming the columns of the Master dataset 

### Combining subject data
The data frame 'subject' is created which combines the subject_test and subject_train data, using the rbind() function.  The column name is assigned as "Subject"

### Creating "Group" column
To identify which records are from the test and train groups, a data frame called 'group' is created with a single column is created repeating the strings "test" and "train" for the number of rows of each corresponding dataset.  The column name is assigned as "Group"

## Assembling Master Data

### Creating data, naming and selecting columns
The data frame 'Master' is created by combining the datasets X_test and X_train.  The features data is applied to the Master data as the column names.  The variable "keep" calculates which columns have and mean and standard deviation data.  It does so by using the grepl() function to index which column names contain the string patterns "mean()" and "std()" in the column names, and the select() function (dplyr package) is applied to keep the columns of Master according to the "keep" index.  

### Adding columns, Finished Master data
Using the cbind() function, the single column data frames 'subject,' 'group,' and 'y' are combined to "Master" data.  The Master data is complete!

## Create Final Data, Write txt File

### Create "Tidy" data
Using the %>% pipe operator, group_by() and summarise_each() functions from the dplyr package, the Master data is grouped by 'subject' ID and averaged for each variable with the mean() function.  The  data is then ordered by subject with the arrange function (dplyr package) 

### Write .txt file
The file is written with write.table() and writes the file in the current working directory.  See the README.md file for a description of the final data.  
