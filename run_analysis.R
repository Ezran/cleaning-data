if (!file.exists("data.zip")){
	download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","data.zip",method="curl")
	dateDownloaded <- date()
} else message("zip file exists, skipping download...")

unzip("data.zip", overwrite = FALSE)
base_wd <- getwd()

#get the labels from features / activity labels
setwd("UCI HAR Dataset")
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

#merge training data
setwd("train")
train <- cbind(read.table("X_train.txt"), read.table("y_train.txt"), read.table("subject_train.txt"))
names(train) <- c(as.vector(features$V2),"Activity Type", "Subject Number")

#merge test data
setwd(paste("./../test"))
test <- cbind(read.table("X_test.txt"),read.table("y_test.txt"),read.table("subject_test.txt"))
names(test) <- names(train)

#merge both data sets
data <- rbind(test,train)

#filter out mean and std
mean_std <- grep(".*mean().*|.*std().*", features[,2])
mean_std <- c(mean_std, 562, 563)
data <- data[,mean_std]

#replace activity int with string (does not work?)
for (i in 1:nrow(activity_labels)) {
	data$'Activity Type'[data$'Activity Type' == i] <- activity_labels[i,2]
}

#average rows
avg <- colMeans(data[1:79,])

#reset working directory
setwd(base_wd)
