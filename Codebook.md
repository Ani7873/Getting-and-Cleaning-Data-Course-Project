Course Project
===========

Aniruddha Raghavan


Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

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

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

Steps in run_analysis.R
==================

	•	After setting the source directory for the files, read into tables the data. 
	•	Merge the train and test data into one dataset using rbind function.
	•	Assign column names according to the data available in features.txt.
	•	Extract only the measurement on the mean and standard deviation using the grep function.
	•	Remove the meanFrequency columns from the data.
	•	Use the descriptive activity names from the file activity_labels.txt.
	•	Use the gsub function to change the existing variable names into more meaningful.
	•	Melt the data set and create a tidy data file which includes only the average of each variable for each activity 		and each subject using dcast function.


Data Transformation in  run_analysis.R
==============================

After you run the run_analysis.R file, you should get a tidy_data.txt file.

Here follows a description of tidy_data.txt what looks like.

	1	The first variable denotes the subject number that performed an activity. In total there are 30 subjects.
	2	The second variable denotes the activity performed by the subject. There are six activites, listed here:
	•	WALKING
	•	WALKING_UPSTAIRS
	•	WALKING_DOWNSTAIRS
	•	SITTING
	•	STANDING
	•	LAYING

A total of 66 features were selected from the original data: only the estimated mean and standard deviations, using a grep.These features form the 66 other variables in the dataset, making a total of 68 columns. The feature names from the original data have been rewritten, using the following rules:

	•	The prefix was rewritten t into time to make it clear the feature corresponds to the time domain
	•	The prefix  was rewritten f into freq to make it clear the feature corresponds to the frequency domain
	•	dashes and parentheses have been removed

