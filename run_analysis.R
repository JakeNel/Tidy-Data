run_analysis <- function (dir) {
    library(data.table)
    library(plyr)
    library(dplyr)
    ## Step 1
    X_test <- fread(file.path(dir, "test/X_test.txt"))
    y_test <- fread(file.path(dir, "test/y_test.txt"))
    subject_test <- fread(file.path(dir, "test/subject_test.txt"))
    X_train <- fread(file.path(dir, "train/X_train.txt"))
    y_train <- fread(file.path(dir, "train/y_train.txt"))
    subject_train <- fread(file.path(dir, "train/subject_train.txt"))
    activity_labels <- fread(file.path(dir, "activity_labels.txt"))
    features <- fread(file.path(dir, "features.txt"))
    ## Step 2
    features <- t(select(features, V2))
    y <- rbind(y_test, y_train)
    y <- data.frame(mapvalues(y$V1, from = 1:6, to = activity_labels[1:6, V2]))
    subject <- rbind(subject_test, subject_train)
    group <- data.frame(c(rep.int("Test", nrow(X_test)), rep.int("Train", nrow(X_train))))
    colnames(y) <- "Activity_Labels"
    colnames(subject) <- "Subject"
    colnames(group) <- "Group"
    ## Step 3
    Master <- rbind(X_test, X_train)
    colnames(Master) <- features 
    keep <- sort(c(which(grepl("std()", colnames(Master), fixed = TRUE)), 
                       which(grepl("mean()", colnames(Master), fixed = TRUE))))
    Master <- select(Master, keep)
    Master <- cbind(subject, group, y, Master)
    Tidy <- data.frame(Master %>% group_by(Subject) 
                            %>% summarise_each(funs(mean)))
    Tidy <- arrange(Tidy, Subject)
    ## Step 4
    write.table(Tidy, file = "./Tidy.txt", row.names = FALSE)
}