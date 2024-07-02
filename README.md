Project title: Getting-and-Cleaning-Data-Course-Project

Significance: The goal is to prepare tidy data that can be used for later analysis. 

Useful links:
1. Raw dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Github repository with code book and run_analysis.R file https://github.com/Mash-shell/Getting-and-Cleaning-Data-Course-Project

The associated R script called run_analysis.R does the following: 
1. Installs all required tools
2. Downloads the given file from the url and rename the unzipped file
3. Loads the labels and features
4. Loads the training data
5. Loads the test data
6. Merges the training and the test sets to create one data set.
7. Labels to activity conversion
8. Writes the contents of the mergedData into a file named myMergedData.txt
