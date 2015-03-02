library("dplyr")
library("tidyr")

#read in variables labels
variables <- read.table("UCI HAR Dataset/features.txt")

#read in training data
dat_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
colnames(dat_train) <- variables[,2]

#read in training subject and add subject variable to training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
dat_train <- cbind(dat_train,subject_train)
names(dat_train)[562] <- c("subject_number")

#read in and add activity variable to training data
activity_train <- as.data.frame(read.table("UCI HAR Dataset/train/y_train.txt"))
names(activity_train)[1] <- c("activity_number")
dat_train <- cbind(dat_train,activity_train)

#read test data
dat_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
colnames(dat_test) <- variables[,2]

#read in training subject and add subject variable to test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
dat_test <- cbind(dat_test,subject_test)
names(dat_test)[562] <- c("subject_number")

#read in and add activity variable to test data
activity_test <- as.data.frame(read.table("UCI HAR Dataset/test/y_test.txt"))
names(activity_test)[1] <- c("activity_number")
dat_test <- cbind(dat_test,activity_test)

#combine training and test data
dat_complete <- rbind(dat_train, dat_test)

#read in activity lables and join to dataframe
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activity_number","activity")
dat_complete <- full_join(dat_complete,activity_labels, by = "activity_number")

#select only the mean and sd columns and add back the identifying variables
dat_meansd <- dat_complete[,grep("(mean|std)\\(\\)",colnames(dat_complete))]
dat_meansd <- cbind(dat_meansd, dat_complete[,562:564])

#create tidy version of dat_meansd
dat_tidy <- gather(dat_meansd, reading, value, 1:66)

#eliminate the activity number as we already have the descriptions included
dat_tidy <- dat_tidy[,-2]

#create tidy data frame with the means for each subject/activity/reading
dat_final <- dat_tidy %>% group_by(subject_number, activity, reading) %>% summarize(mean_value = mean(value))
head(dat_final)

write.table(dat_final, "dat_final.txt", row.name = FALSE)