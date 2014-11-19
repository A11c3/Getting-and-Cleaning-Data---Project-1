#In this Code Book:
#describes the variables, the data, and any transformations or work that you #performed to clean up the data

# Data files:
subject_test.txt		Subject identifiers
X_test.txt			feature data
y_test.tx			Activity identifier
subject_train.txt		Subject identifiers
X_train.txt			feature data
y_train.txt			Activity identifier
features.txt

Activity Labels
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

Subject identifiers: 1, 2, 3, ......., 30

Example features
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

# run_analysis.R Variables
#########################################################
ds			Subject identifiers - test data
dsTr 			Subject identifiers - training data
dy 			Activity identifier - test data
dyTr 			Activity identifier - training data
dx 			feature file from which means and std are selected for the test data
dxTr  			featre file from which means and std are selected for the training data 
featLabels 		a descriptive list of the data in each column of the feature files - used with colnames to give a descriptive column heading to the data in the features file.

testMeans 			table of columns with "mean" in the heading from dx
testStd 			table of columns with "std" in the heading from dx
testData 			[Subject, Activity.Code "......"mean", ....... ,"....."std" ]
trainingMeans 		table of columns with "mean" in the heading from dxTr
trainingStd 			table of columns with "std" in the heading from dxTr
trainingData 		[Subject, Activity.Code "......"mean", ....... ,"....."std" ]
allData 			Training and test data combined into one data frame

allDataMelt				The function "melt" applied to allData
TidyDataSummary		The function "cast" applied to allDataMelt

##############################################################

#Description
############################################################
The data is originally a set of .txt files with various bits of information in them.

1.	Relevant files are imported 
2. 	Descriptive headings are assigned to each column of the feature file using the feature Labels
3.	The subject and activity identifiers are combined with the mean and standard deviation data for both the test and training data. - Tables testMeans, trainingMeans, trainingStd and testStd are created by string matching "mean" and "sdr" to the column headings.
4. 	This is done once for the test data then repeated for the training data
5. 	The test and training subsets, testData and trainingData, are then combined into one data frame, allData.
6.	Activity numbers are replaced with descriptive labels
7.	The data is put into Subject order, 1,2,3,........30
8.	Reshape the data - melt forces the data frame into variable and value ordering first by "Subject" then by "Activity.Code"
9.	allDataMelt is used to find the mean of the values in the column "variable" grouped by "Subject" and "Activity.Code"  and saved in the file TidyDataSummary
10.	TidyDataSummary is saved as a text file