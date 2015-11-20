## Raw data summary 
The raw data can be downloaded at the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Once extracted, the folders contain various text files that contain data by Samsung on triaxial accelerometers and gyroscope
readings during different common daily motion actiivities.  The data is randomly separated into test and training groups for
comparative research.  Important labeling and README data can be found at the top of the directory.  Test and training 
sub-datasets can be found in the folders "Test" and "train".  Each of these folders contains data in "inertial signals"
which consists of the raw input data, while the test and train datasets contains its summary data.  The run_analysis() function 
only extracts specific summary data, and so the inertial signals will not be extracted or modified.

### X_test and X_train
Located in the test and train files respectively, these files contain several 'untidy' summary data for each subject over  
561 variables (labels for which are found in 'features').   
