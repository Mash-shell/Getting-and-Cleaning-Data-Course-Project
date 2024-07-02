
# Step 1: let's install all required tools
requiredTools <- c("data.table", "reshape2")
sapply(requiredTools, require, character.only=TRUE, quietly=TRUE)
workingDirectory  <- getwd()

# Step 2: let's download the given file from the url and rename the unzipped file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(workingDirectory, "myData.zip"))
unzip(zipfile = "myData.zip")

# Step 3: Let's load the labels and features
activityLabels <- fread(file.path(workingDirectory, "UCI HAR Dataset/activity_labels.txt")
                        , col.names = c("classLabels", "activityName"))
features <- fread(file.path(workingDirectory, "UCI HAR Dataset/features.txt")
                  , col.names = c("index", "featureNames"))
desiredFeatures <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[desiredFeatures, featureNames]
measurements <- gsub('[()]', '', measurements)

# Step 4: let's load our training data
train <- fread(file.path(workingDirectory, "UCI HAR Dataset\\train\\X_train.txt"))[, desiredFeatures, with = FALSE]
data.table::setnames(train, colnames(train), measurements)
activityTrain <- fread(file.path(workingDirectory, "UCI HAR Dataset\\train\\Y_train.txt")
                       , col.names = c("Activity"))
subjectTrain <- fread(file.path(workingDirectory, "UCI HAR Dataset\\train\\subject_train.txt")
                       , col.names = c("SubjectNum"))
train <- cbind(subjectTrain, activityTrain, train)

# Step 5: let's load our test data
test <- fread(file.path(workingDirectory, "UCI HAR Dataset\\test\\X_test.txt"))[, desiredFeatures, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
activityTest <- fread(file.path(workingDirectory, "UCI HAR Dataset\\test\\Y_test.txt")
                        , col.names = c("Activity"))
testSubjects <- fread(file.path(workingDirectory, "UCI HAR Dataset\\test\\subject_test.txt")
                      , col.names = c("SubjectNum"))
test <- cbind(testSubjects, activityTest, test)

# Step 6: let's merge both training and test data
mergedData <- rbind(train, test)

# Step 7: label to activity conversion  
mergedData[["Activity"]] <- factor(mergedData[, Activity]
                              , levels = activityLabels[["classLabels"]]
                              , labels = activityLabels[["activityName"]])

mergedData[["SubjectNum"]] <- as.factor(mergedData[, SubjectNum])
mergedData <- reshape2::melt(data = mergedData, id = c("SubjectNum", "Activity"))
mergedData <- reshape2::dcast(data = mergedData, SubjectNum + Activity ~ variable, fun.aggregate = mean)

# Step 8: let's write the contents of the mergedData into a file named myMergedData.txt
data.table::fwrite(x = mergedData, file = "myMergedData.txt", quote = FALSE)
