CodeBook for the Cleaning Data Project
=========

This is the CodeBook for the Cleaning Data Project, a class project for the Cleaning Data course on coursera.org

The data was collected by experiments of 30 volunteers who each wore a cellphone that captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.  More details of the data is available at [the UCI Machine Learning Repository]( http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  

This document accompanies an R script that processes the raw data available on the above website, explains the process of running the script, choices made in tidying the data as well as a description of the variables in the final dataset. 

The Data
-----

As mentioned above, the data is available at [the UCI Machine Learning Repository]( http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and [a zip file of the data is avaiable](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/).  These websites (and the README file in the zip file) explain in detail the data.  In short, there is a training set and a test set of data that have been processed from the cell phones with 561 variables.  The training data is in the file `UCI HAR Dataset/test/X_train.txt` and the test set is in the file `UCI HAR Dataset/test/X_train.txt`.  

The Processing Script
-------

The processing script is written in R and called `run_analysis.R`.  To run it, make sure that the zip file `UCI HAR Dataset.zip` is unzipped in the same directory as `run_analysis.R`, the script will run resulting in a file called `uci_har_summary.txt`. 

In short, the script merges the data from the training and test sets, labels the activity for each observativation, labels the test subject for each observation, selects only given variables, summarizes the data over each activity and subject, resulting in the summary file listed above.  The details of this are as follows:



The Variables
-------

Although the original data has 561 variable, for this data set, we have select only a subset of these, although the list is still large. 
Without going into details of all, here are ways of interpreting this. 

* time -- a prefix saying that the variable is in the time domain
* freq -- a prefix saying that the variable is in the frequency domain
* body.acc -- the linear acceleration of the device.  This occurs in the x, y and z directions.
* body.gyro -- the angular accerlation of the device.  Also in the x,y, and z directions.
* body.acc.jerk -- the linear jerk of the device. Also in the x,y, and z directions.
* body.acc.gyro.jerk -- the angular jerk of the device. Also in the x,y, and z directions.
* mean -- a suffix saying that the varaible is the mean of the data.
* std -- a suffix saying that the variable is the standard deviation of the data. 

For example, the variable `time.body.gyro.std.x` is the standard deviation of the angular acceleration (x-component) in the time domain.  

There are 66 combinations of these in the tidied data set.  In addition, there are three other variables:

* type -- the type of data set it came from either "test" or "train"
* activity -- one of the 6 types of activities: "STANDING", "SITTING", "LAYING", "WALKING", "WALKING_DOWNSTAIRS" or "WALKING_UPSTAIRS"
* subject.id -- the id number (1 to 30) of the subject.  


The Resulting Dataset
------

As described above, the script produces a file called `uci_har_summary.txt`, a csv file containing the summary of the data.  For each of the 66 variables explained above, the mean is taken for each activity and subject.id.  The file contains 180 rows, one for each combination of these 6 activities and 30 subjects.  