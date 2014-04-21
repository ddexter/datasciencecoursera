complete <- function(directory, id = 1:332)
{
  res <- numeric(length(id))
  for(i in seq_along(id))
  {
    fi <- sprintf("%03d.csv", id[i])
    data <- read.csv(file.path(directory, fi))
    res[i] <- nrow(na.omit(data))
  }
  
  data.frame(id=id, nobs=res)
}