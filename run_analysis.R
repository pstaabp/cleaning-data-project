
dataDir <- "/Volumes/Drobo/Transporter/peter/classes/cleaning data/data"
if(!file.exists(dataDir)){
    dir.create(dataDir)
}

fileURL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file1 <- file.path(dataDir,"project.zip")

if(!file.exists(file1)){
    download.file(fileURL1,destfile = file1,method="curl")
}

projectDir = file.path(dataDir,"UCI HAR Dataset")
if(!file.exists(projectDir)){
    unzip(file1)
}

# load in the features data set.  This will give the X_test.txt and X_train.txt column names. 
featuresDataFile = file.path(dataDir,"UCI HAR Dataset","features.txt");
features <- read.table(featuresDataFile,col.names = c("var.number","var.name"))

activitiesDataFile = file.path(dataDir,"UCI HAR Dataset","activity_labels.txt")
activities <- read.table(activitiesDataFile,col.names=c("activity.number","activity.name"))

testXDataFile=file.path(dataDir,"UCI HAR Dataset","test","X_test.txt") 
testYDataFile=file.path(dataDir,"UCI HAR Dataset","test","y_test.txt") 
subTestDataFile=file.path(dataDir,"UCI HAR Dataset","test","subject_test.txt")
testX <- read.table(testXDataFile,col.names = features[,2])
testY <- read.table(testYDataFile)
subTest <- read.table(subTestDataFile)

trainXDataFile=file.path(dataDir,"UCI HAR Dataset","train","X_train.txt") 
trainYDataFile=file.path(dataDir,"UCI HAR Dataset","train","y_train.txt")
subTrainDataFile=file.path(dataDir,"UCI HAR Dataset","train","subject_train.txt")
trainX <- read.table(trainXDataFile,col.names = features[,2])
trainY <- read.table(trainYDataFile)
subTrain <- read.table(subTrainDataFile)

# select only the columns from the X_test and X_train data frames with columns that contain mean or std
test_df <-select(testX,matches("(mean[.]{2})|(std[.]{2})"))
train_df <-select(trainX,matches("(mean[.]{2})|(std[.]{2})"))


# label the data with "train" or "test" as a type 

test_df$type<-"test"
train_df$type<-"train"

# include the 
test_df <- test_df %>% mutate(activity = activities$activity.name[testY[,1]],subject.id = subTest[,1])
train_df <- train_df %>% mutate(activity = activities$activity.name[trainY[,1]],subject.id = subTrain[,1])

# merge (by rows) the test and training data sets. 

data<-rbind(test_df,train_df)

## the variable data now contains the tidy set asked for in step 4 of the project. 

vars<-names(data)

grouped_data <- data %>% tbl_df() %>% group_by(activity,subject.id)

## this applies the mean function to each of the first 66 variables (the last three are not descriptive variabels. )

dots <- lapply(vars[1:66] ,function(x) substitute(mean(x), list(x=as.name(x))))

## this is the summarized dataset in 
summarized_data <- do.call(summarize, c(list(.data=grouped_data), dots))

write.table(summarized_data,file="summ_data.txt",row.names = FALSE)

