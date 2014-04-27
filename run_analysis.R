

data_pathway <- "C:/Users/Christian/Documents/data/UCI HAR Dataset"
setwd(data_pathway)

##########
##PART 1##
##########

#############################################
## Read all the data in from the text files##
#############################################

## Read in activity labels
feature_labels <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")
test_activity <- read.table("test/y_test.txt")
train_activity <- read.table("train/y_train.txt")
test_subject <- read.table("test/subject_test.txt")
train_subject <- read.table("train/subject_train.txt")

## Read in the activity data
test_data <- read.table("test/X_test.txt")
train_data <- read.table("train/X_train.txt")


############
## Part 3 ##
############

#############################
## Label the data variables##
#############################

names(train_subject) <- "subject"
names(train_activity) <- "activity"
names(train_data) <- feature_labels[,2]

names(test_subject) <- "subject"
names(test_activity) <- "activity"
names(test_data) <- feature_labels[,2]

names(activity_labels) <- c("id", "labels")

############################
## Merge the two data sets##
############################

## Merge the train data with labels

full_train_data <- cbind(train_subject, train_activity, train_data)

## Merge the test data with labels

full_test_data <- cbind(test_subject, test_activity, test_data)

## Combine the two full datasets

merge_data <- rbind(full_train_data, full_test_data)


############
## Part 2 ##
############

#################################################
## Extract mean and std dev of each measurement##
#################################################

measures_of_means_and_std <- merge_data[,grepl("subject|activity|[Mm][Ee][Aa][Nn]\\(\\)|[Ss][Tt][Dd]\\(\\)",names(merge_data))]


############
## Part 4 ##
############

measures_of_means_and_std_with_labels <-merge(measures_of_means_and_std[,c(1:ncol(measures_of_means_and_std))], activity_labels, by.x = "activity", by.y = "id")


############
## Part 5 ##
############

data_subset <- data.frame(matrix(nrow=0, ncol=ncol(merge_data)))
names(data_subset) <- names(merge_data)

for(i in 1:30) {
    for(j in 1:6) {
        temp <- merge_data[,merge_data$subject == i & merge_data$activity == j]
        temp_means <- colMeans(temp)
        c(i, j, temp_means)
        rbind(data_subset, temp_means)
    }
}
