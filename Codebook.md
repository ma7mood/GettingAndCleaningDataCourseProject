# The script run_analysis.R produces tidy data from the raw data.

### Data Preparation

1. Download and unzip the dataset into the folder "UCI HAR Dataset".
2. Extract the features, activity, and subject data for the test set and the train set.
3. Merge the features, activity, and subject data for both the test set and the train set creating a data frame.
4. Extract feature variable names from 'features.txt'
5. Give descriptive names to all the variables.
6. Extract the mean and standard deviation measurements from the features/
7. Average all the activities for each subject 
8. Create the new tidy data set and write it in the file 'smartPhoneAverages.txt'

Note: There were no missing values that needed filling.


### Variables used in the analysis

* The various subject, feature and activity information that is already provided in the dataset:
  * testFeatures
  * trainFeatures
  * testActivity
  * trainActivity
  * testSubject 
  * trainSubject 
* After merging the training and testing dataset:
  * features
  * activity
  * subject
* smartphoneData : data frame with the features, activity, and subject combined
* MeanAndStd : mean and standard deviation variables in the features data
* SmartphoneData_MeanStd : smartphoneData with only the mean and standard deviation features
* activityNames : labels for the 6 types of activities
* smartPhoneAverages : smartphoneData but containing only the average of each variable for each activity and each subject
