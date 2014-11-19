# change the working directory to /UCI HAR Dataset

#load packages
library(reshape2)

# import the test data
ds = read.table("test/subject_test.txt")
dy = read.table("test/y_test.txt")
dx = read.table("test/X_test.txt")
featLabels = read.table("features.txt")

# changing the column names of dx for the feature names
colnames(dx)<- c(as.character(featLabels[,2]))
#
# for the person/subject and activity names 
colnames(ds)<- c("Subject")
colnames(dy)<- c("Activity Code")

# Selecting the columns which contain means
testMeans<- dx[,grep("mean", names(dx)) ]

# Selecting the columns that contain standard deviations
testStd<- dx[,grep("std", names(dx)) ]

#Collecting the test data into one data frame
testData<- data.frame( ds, dy, testMeans, testStd)

###############################################################

# import the training data
dsTr = read.table("train/subject_train.txt")
dyTr = read.table("train/y_train.txt")
dxTr = read.table("train/X_train.txt")

# changing the column names of dx for the feature names
colnames(dxTr)<- c(as.character(featLabels[,2]))
#
# for the person/subject and activity names 
colnames(dsTr)<- c("Subject")
colnames(dyTr)<- c("Activity Code")

# Selecting the columns which contain means
trainingMeans<- dxTr[,grep("mean", names(dxTr)) ]

# Selecting the columns that contain standard deviations
trainingStd<- dxTr[,grep("std", names(dxTr)) ]

#Collecting the test data into one data frame
trainingData<- data.frame( dsTr, dyTr, trainingMeans, trainingStd)

#################################################################

# combining the data into one data frame with all subjects data

allData<- rbind(testData, trainingData)

# Setting the activity from number to description
loc1<- allData[,2] == 1
allData[loc1,2] = "Walking"
loc2<- allData[,2] == 2
allData[loc2,2] = "Walking_Upstairs"
loc3<- allData[,2] == 3
allData[loc3,2] = "Walking_Downstairs"
loc4<- allData[,2] == 4
allData[loc4,2] = "Sitting"
loc5<- allData[,2] == 5
allData[loc5,2] = "Standing"
loc6<- allData[,2] == 6
allData[loc6,2] = "Laying"

# Ordering the data in subject number
allData<- allData[order(allData$Subject),]

#
#Reshape the data set to summarize data
# melt forces the data frame into variable and value ordering first by "Subject" then by "Activity.Code"
allDataMelt<- melt(allData, id = c("Subject", "Activity.Code"))

# now use allDataMelt to find the mean of the values in the column "variable" grouped by "Subject" and "Activity.Code" 
TidyDataSummary <- dcast(allDataMelt, Subject + Activity.Code ~ variable, mean)
#
# Save the file
write.table(TidyDataSummary, file = "TidyDataSummary.txt", row.names = FALSE)