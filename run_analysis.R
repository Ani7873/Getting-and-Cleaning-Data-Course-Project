#Import training and testing data from the directory

subject_train = read.table('subject_train.txt')
X_train = read.table('X_train.txt')
y_train = read.table('y_train.txt')
subject_test = read.table('subject_test.txt')
X_test = read.table('X_test.txt')
y_test = read.table('y_test.txt')
body_acc_x_train = read.table('body_acc_x_train.txt')
body_acc_y_train = read.table('body_acc_y_train.txt')
body_acc_z_train = read.table('body_acc_z_train.txt')
body_gyro_x_train = read.table('body_gyro_x_train.txt')
body_gyro_y_train = read.table('body_gyro_y_train.txt')
body_gyro_z_train = read.table('body_gyro_z_train.txt')
total_acc_x_train = read.table('total_acc_x_train.txt')
total_acc_y_train = read.table('total_acc_y_train.txt')
total_acc_z_train = read.table('total_acc_z_train.txt')
body_acc_x_test = read.table('body_acc_x_test.txt')
body_acc_y_test = read.table('body_acc_y_test.txt')
body_acc_z_test = read.table('body_acc_z_test.txt')
body_gyro_x_test = read.table('body_gyro_x_test.txt')
body_gyro_y_test = read.table('body_gyro_y_test.txt')
body_gyro_z_test = read.table('body_gyro_z_test.txt')
total_acc_x_test = read.table('total_acc_x_test.txt')
total_acc_y_test = read.table('total_acc_y_test.txt')
total_acc_z_test = read.table('total_acc_z_test.txt') 

# Merging train and test data into one dataframe

X_data = rbind(X_train,X_test)
y_data = rbind(y_train,y_test)
subject_data = rbind(subject_train,subject_test)
body_acc_x_data = rbind(body_acc_x_train,body_acc_x_test)
body_acc_y_data = rbind(body_acc_y_train,body_acc_y_test)
body_acc_z_data = rbind(body_acc_z_train ,body_acc_z_test)
body_gyro_x_data = rbind(body_gyro_x_train,body_gyro_x_test)
body_gyro_y_data = rbind(body_gyro_y_train,body_gyro_y_test)
body_gyro_z_data = rbind(body_gyro_z_train,body_gyro_z_test)
total_acc_x_data = rbind(total_acc_x_train,total_acc_x_test)
total_acc_y_data = rbind(total_acc_y_train,total_acc_y_test)
total_acc_z_data = rbind(total_acc_z_train,total_acc_z_test)

#Adding the Activity and Subject to the main data 
data = cbind(X_data,y_data,subject_data)
feature_names = read.table('features.txt')
names(data)[562] = "Activity"
names(data)[563] = "Subject"

#Extracting only the measurements on the mean and Standard deviation for each measurement
cols = grep(".*-mean().*|.*std().*",feature_names[,2])
cols = c(cols,562,563)

#Removing MeanFrequency columns from the extracted columns and creating the new dataset
cols2 = grep("meanFreq",feature_names[,2])
c = subset(cols,!(cols%in%cols2))
data_1 = data[,c]

#Naming the activities with descriptive names
activity_labels = read.table("activity_labels.txt")
data_1 = data.frame(data_1)
data_1 = within(data_1, Activity <- factor(Activity,labels = activity_labels$V2))
data_1$Subject = as.factor(data_1$Subject)
colNames = colnames(data_1)

#Labeling dataset with proper variable names
for (i in 1:length(colNames)) 
{
		colNames[i] = gsub("\\()","",colNames[i])
		colNames[i] = gsub("-std$","StdDev",colNames[i])
		colNames[i] = gsub("-mean","Mean",colNames[i])
		colNames[i] = gsub("^(t)","time",colNames[i])
		colNames[i] = gsub("^(f)","freq",colNames[i])
		colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
		colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
		colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
		colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
		colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
		colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
		colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};
colnames(data_1) = colNames
data_1 = melt(data_1,id.vars=c("Subject","Activity"))
#Creating a tidy dataset with the average of each variable for each activity and each subject
tidy_data = dcast(data_1,Subject+Activity~variable,mean)
write.table(tidy_data,file="Tidy_data.txt",row.names=FALSE)





