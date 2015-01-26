# cleaning-data
coursera cleaning data course project

This script downloads the dataset if it cannot find a .zip it previously downloaded, or the containing folder within the working directory.

It will read the training and test data, and merge it into one data set named *data*.  It then attaches the labels to the columns from the features.txt file.  Once complete it will create and return a new data set *avg* that contains the average measurement of each column.  

The activity number is not converted into the label found in the activity.txt file.
