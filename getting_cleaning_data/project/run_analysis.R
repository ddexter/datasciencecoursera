library("hash")

TOP_DIR <- "UCI\ HAR\ Dataset"
TEST_DIR <- "test"
TRAIN_DIR <- "train"
ACTIVITY_LABEL_PATH <- "activity_labels.txt"
FEATURE_LABEL_PATH <- "features.txt"
DATA_FILE_TEST <- "X_test.txt"
SUBJECT_FILE_TEST <- "subject_test.txt"
ACTIVITY_FILE_TEST <- "y_test.txt"
DATA_FILE_TRAIN <- "X_train.txt"
SUBJECT_FILE_TRAIN <- "subject_train.txt"
ACTIVITY_FILE_TRAIN <- "y_train.txt"
ID_PAIR <- c("subject", "activity") # Identify data by subject/activity pair
OUT_FILE = "tidy_avg_subject_activity.txt"

# Given a column number a key and the hash map of column names, identifies if
# the column name contains mean() or std()
filter_mean_std <- function(i, feature_name_map) {
  grepl("(mean\\(\\)|std\\(\\))", feature_name_map[[as.character(i)]], perl=TRUE)
}

# Gets the map of (id. #, str-val) pairs
get_map <- function(f) {
  f_table <- read.table(f)
  hash(keys=f_table$V1, values=f_table$V2)
}

# Returns a vector from the lines of a file
get_file_vector <- function(f) {
  f_table <-read.table(f)
  f_table$V1
}

# Extracts the relevant data from the file along the path
extract_data <- function(subject_file, activity_file, data_file,
                         activity_label_map, valid_indices,
                         feature_column_names) {
  subjects <- get_file_vector(subject_file)
  activity_ids <- get_file_vector(activity_file)
  activities <- sapply(activity_ids, function(i, h) h[[as.character(i)]],
    h=activity_label_map)

  df1 <- data.frame(subjects, activities)
  colnames(df1) <- ID_PAIR

  df2 <- read.table(data_file)[ ,valid_indices]
  colnames(df2) <- feature_column_names

  cbind(df1, df2)
}

# Read the indice to activity/feature mapping files in as hashmaps
activity_label_map <- get_map(file.path(TOP_DIR, ACTIVITY_LABEL_PATH))
feature_name_map <- get_map(file.path(TOP_DIR, FEATURE_LABEL_PATH))

# Get the features with mean() or std()
feature_columns <- as.numeric(keys(feature_name_map))
valid_feature_indices <- sort(feature_columns[sapply(feature_columns,
  filter_mean_std, feature_name_map=feature_name_map)])
feature_column_names <- values(feature_name_map, USE.NAMES=FALSE, keys=valid_feature_indices)

test_data <- extract_data(file.path(TOP_DIR, TEST_DIR, SUBJECT_FILE_TEST),
                     file.path(TOP_DIR, TEST_DIR, ACTIVITY_FILE_TEST),
                     file.path(TOP_DIR, TEST_DIR, DATA_FILE_TEST),
                     activity_label_map, valid_feature_indices,
                     feature_column_names)

training_data <- extract_data(file.path(TOP_DIR, TRAIN_DIR, SUBJECT_FILE_TRAIN),
                              file.path(TOP_DIR, TRAIN_DIR, ACTIVITY_FILE_TRAIN),
                              file.path(TOP_DIR, TRAIN_DIR, DATA_FILE_TRAIN),
                              activity_label_map, valid_feature_indices,
                              feature_column_names)

data <- rbind(test_data, training_data)
data <- data[with(data, order(subject, activity)), ]
rownames(data) <- 1:nrow(data)

# Average the data
averaged_data <- aggregate(data[, 3:ncol(data)], by=list(data[ ,1], data[ ,2]), FUN=mean)
new_col_names = c(ID_PAIR, sapply(feature_column_names, function(s) paste("mean", s)))
colnames(averaged_data) <- new_col_names

write.fwf(averaged_data, OUT_FILE, quote=FALSE, sep=" ", row.names=FALSE)

