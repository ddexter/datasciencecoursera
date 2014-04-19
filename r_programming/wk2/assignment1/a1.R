pollutantmean <- function(directory, pollutant, id = 1:332)
{
  tot <- 0
  n <- 0
  for(i in id)
  {
    fi <- sprintf("%03d.csv", i)
    data <- read.csv(file.path(directory, fi))
    clean_vector <- na.omit(data[, pollutant])
    tot <- tot + sum(clean_vector)
    n <- n + length(clean_vector)
  }
  tot / n
}