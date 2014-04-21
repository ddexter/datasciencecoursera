corr <- function(directory, threshold = 0)
{
  valid_counts <- complete(directory, 1:length(list.files(directory)))
  valid_counts <- valid_counts[valid_counts$nobs > threshold, "id"]
  res <- numeric(length(valid_counts))
  for(i in seq_along(valid_counts))
  {
    fi <- sprintf("%03d.csv", valid_counts[i])
    data <- na.omit(read.csv(file.path(directory, fi)))
    res[i] <- cor(data[,"sulfate"], data[,"nitrate"])
  }
  res
}