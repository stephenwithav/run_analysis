test_subject <- read.table("./test/subject_test.txt")
test_X <- read.table("./test/X_test.txt")
test_Y <- read.table("./test/y_test.txt")


train_subject <- read.table("./train/subject_train.txt")
train_X <- read.table("./train/X_train.txt")
train_Y <- read.table("./train/y_train.txt")


features <- read.table("./features.txt", colClasses=c("numeric", "character"))
activity_labels <- read.table("./activity_labels.txt", colClasses=c("numeric", "character"), col.names=c("ActivityID", "Activity Name"))


# Step 1.
dataset <- rbind(test_X, train_X)
colnames(dataset) <- features[,2]


# Step 2.
dataset <- dataset[, grep(pattern="-(mean|std)\\(\\)", x=features[,2])]
features <- c(c("SubjectID"), colnames(dataset), c("Activity"))

dataset <- cbind(rbind(test_subject, train_subject), dataset, rbind(test_Y, train_Y))
colnames(dataset) <- features


# Step 3.
dataset[,"Activity"] <- activity_labels[dataset[,"Activity"], 2]


# Step 4.
patterns <- c("([a-z])([A-Z])", "^t", "^f", "Acc", "Gyro", "Mag")
substitutions <- c("\\1_\\2", "time", "frequency", "acceleration", "gyroscope", "magnitude")

for (i in 1:length(patterns)) features <- gsub(patterns[i], substitutions[i], features)
features <- tolower(features)
colnames(dataset) <- features


# Step 5.
tidyset <- aggregate(dataset, list(dataset$subject_id, as.factor(dataset$activity)), mean)
colnames(tidyset) <- c(c("SubjectID", "Activity"), paste("avg", features, sep="_"))

tidyset <- tidyset[,!(colnames(tidyset) %in% c("avg_activity", "avg_subject_id"))]

write.csv(tidyset, "tidyset.csv", row.names=FALSE)
