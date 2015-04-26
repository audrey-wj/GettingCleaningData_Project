# GettingCleaningData_Project
Course Project for Coursera's Getting and Cleaning Data offered by JHU.

Function run_analysis(filename)

###Input Variable
1. The function takes one input variable ("filename"), which should be a .zip file downloaded from this URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Filename should be included in double quote marks and shoud not be unzipped. It should be stored in the R working directory. 

###Output Variable
1. The function's output is a data frame with the tidy dataset.
2. It is recommended that an R object is used to receive the output to avoid displaying all the data. For example, 
tidydata <- run_analysis("myfilename.zip")

###Other Notes
1. The run_analysis.R file should be saved under the same working directory where the .zip file is saved. And please make sure to run this code before using the function:
    source("run_analysis.R")
2. Please make sure these packages are installed before using the function:
    (1) reshape2
    (2) plyr
