---
title: "codebook.md"
author: "Jake"
date: "December 14, 2018"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
##CODE BOOK

Data obtaied from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Description of data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Overview:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

The variables in this dataset include the following:

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autoregression coefficients with Burg order equal to 4
correlation(): Correlation coefficient between two signals
maxInds(): Index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): Skewness of the frequency domain signal 
kurtosis(): Kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between some vectors.

## Data Transformation

The raw datasets are cleaned and transformed using the run_analysis.R script to create a tidy data set (tidyData).

###Merge Training and Testing Datasets
The test and training data (X_train.txt & X_test.txt, Y_train.txt & Y_test.txt), subject ids (subject_test.txt, subject_train.txt) and activity ids (activity_labels.txt) are merged to create a single data set. Variables are named with names assigned by features.txt. 

###Extract mean and standard deviation variables
Only variables with values of estimated mean ("mean") and standard deviation ("std") are then extracted from the merged data set. 

###Change descriptive activity names
Activity names with the activity description is then added to the merged data set using activity_labels.txt for description names. 

###Label variables appropriately
Variable labels were then cleaned to expand upon abbreviations, and remove parenteses, dashes and commas.

###Create a tidy dataset
A final data set (tidyData) was then created with the mean values for each activity and each subject. The tidy data set contains 180 observations of 88 variables. 


