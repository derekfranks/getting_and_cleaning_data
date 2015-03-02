The run_analysis.R script assumes that the appropriate "UCI HAR Dataset" folder containing all of the relevant data files is your working directory.  It does the following:

1. Loads the dplyr and tidyr packages

2. Reads in the vairable labels from the features.txt file

3. Reads in and organizes all of the Training Data
  + Reads in the training data and assigns the variable labels
  + Reads in the training subject data and assigns the subject variable to the training data file
  + Reads in and adds the activity numbers to the training data
  
4. Reads in and organizes all of the Test data
  + Reads in the test data and assigns the variable labels
  + Reads in the test subject data and assigns the subject variable to the test data file
  + Reads in and adds the activity numbers to the test data
  
5. Combines the training and test data into a single data frame

6. Reads in the activity labels and joins them to the data frame using the activity numbers

7. Creates a data frame with only the mean and sd variables

8. Creates a tidy version of the data frame to make it easier to calculate the mean by variable
  + I've used the "long" version of a tidy data frame where I have a "reading" and "value" column and each observation is a new row
  
  
9. Creates a tidy data frame with the means of the mean and sd variables grouped by subject number and activity
10. Writes the final data frame to a file called dat_final.txt
