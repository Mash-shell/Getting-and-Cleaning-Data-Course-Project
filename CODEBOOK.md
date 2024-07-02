*Code Book*

Project title:Getting-and-Cleaning-Data-Course-Project

Significance: The goal is to prepare tidy data that can be used for later analysis. 

Useful links:
1. Raw dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Github repository with README.md and run_analysis.R file https://github.com/Mash-shell/Getting-and-Cleaning-Data-Course-Project

*Description of variables*:
- requiredTools: Installs all required tools using sapply

- download.file (): downloads file
- unzip(): unzips file

- activityLabels: Loads labels from activity_labels.txt using fread()
- features: Loads features from features.txtusing fread()

- desiredFeatures: reads desired features of measurements using grep() and gsub():
    - mean(): Mean value
    - std(): Standard deviation
    
- train: Reads and binds training data together using fread() and cbind() respectively 

- test: Reads and binds test data together using fread() and cbind() respectively 

- mergedData: Merges training and test data together using rbind()

- fwrite(): Writes the contents of the mergedData into a file named myMergedData.txt

