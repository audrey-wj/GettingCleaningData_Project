run_analysis <- function(filename) {
        
        if (!file.exists(filename)) {stop("file not found")}
        #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./data/accelerometers.zip")
        
        ##'train/X_train.txt': Training set.
        ##'train/y_train.txt': activity labels for training.
        ##'test/X_test.txt': Test set.
        ##'test/y_test.txt': activity labels for test.
        
        #read raw data
        feature <- read.table(unz(filename,"UCI HAR Dataset/features.txt"), header = FALSE) # "feature" = metric
        activity_label <- read.table(unz(filename,"UCI HAR Dataset/activity_labels.txt"), header = FALSE)
        test_subject <- read.table(unz(filename,"UCI HAR Dataset/test/subject_test.txt"), header = FALSE)
        test_data <- read.table(unz(filename,"UCI HAR Dataset/test/X_test.txt"), header = FALSE)
        test_label <- read.table(unz(filename,"UCI HAR Dataset/test/y_test.txt"), header = FALSE)
        train_subject <- read.table(unz(filename,"UCI HAR Dataset/train/subject_train.txt"), header = FALSE)
        train_data <- read.table(unz(filename,"UCI HAR Dataset/train/X_train.txt"), header = FALSE)
        train_label <- read.table(unz(filename,"UCI HAR Dataset/train/y_train.txt"), header = FALSE)
        
        #merge test and train data set
        merge_data <- rbind(train_data,test_data)
        #name columns (variables)
        colnames(merge_data) <- feature$V2
        #subset for mean and std metrics only
        feature_filter <- feature[grepl("mean()",feature$V2)|grepl("std()",feature$V2),]
        sub_merge_data <- merge_data[,feature_filter$V1]
        
        #add subject label and activity label
        merge_subject <- rbind(train_subject,test_subject)
        merge_label <- rbind(train_label, test_label)
        data_label <- cbind(merge_subject, merge_label)
        colnames(data_label) <- c("subject", "label")
        sub_merge_data_label <- cbind(data_label, sub_merge_data)
        
        #melt data
        library(reshape2)
        data_melt <- melt(sub_merge_data_label, id = c("subject", "label"), measure.vars = feature_filter$V2)
        
        #calculate mean for each variable by subject and activity
        library(plyr)
        data_mean <- ddply(data_melt, .(subject, label, variable), summarize, mean = mean(value))
        
        #map label id to descriptive names
        colnames(activity_label) <- c("label", "activity")
        data_desc = merge(data_mean, activity_label, by.x = "label", by.y = "label", all = TRUE)
        data_tidy <- data_desc[,c("subject", "activity", "variable", "mean")]
        
        return(data_tidy)
        #export data
        #write.table(data_tidy, file = "./data/accelerometers_tidy.txt", row.names = FALSE)  
}




