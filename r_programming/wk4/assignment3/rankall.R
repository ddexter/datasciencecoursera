BEST_N_COLS = 46
BEST_INCLUDED_COLS = c(2, 7, 11, 17, 23)
BEST_COL_TYPES = c('character', 'character', 'numeric', 'numeric', 'numeric')
BEST_COL_NAMES = c('hospital', 'state', 'heart attack', 'heart failure', 'pneumonia')
BEST_DEATH_TYPES = c('heart attack', 'heart failure', 'pneumonia')
BEST_CSV = 'outcome-of-care-measures.csv'

read_and_format_data <- function(csv) {
  sel <- rep('NULL', BEST_N_COLS)
  sel[BEST_INCLUDED_COLS] <- 'character'
  data <- read.csv(csv, colClasses=sel)
  colnames(data) <- BEST_COL_NAMES
  data[,BEST_DEATH_TYPES] <- apply(data[,BEST_DEATH_TYPES], 2, function(x) as.numeric(x))
  data <- data[order(data[,'hospital']),]
  data
}

read_states <- function(csv) {
  sel <- rep('NULL', BEST_N_COLS)
  sel[7] <- 'character'
  data <- read.csv(csv, colClasses=sel)
  colnames(data) <- 'state'
  unique(data[order(data[,'state']),])
}

rankhospital <- function(state, outcome, rank = 'best') {
  if (!outcome %in% BEST_DEATH_TYPES) {
    stop('invalid outcome')
  }
  data <- read_and_format_data(BEST_CSV)
  if (!state %in% data[,'state']) {
    stop('invalid state')
  }
  data <- data[!is.na(data[,outcome]),]
  data <- data[data$'state' == state,]
  data <- data[order(data[,outcome],data[,'hospital']),]
  if(rank == 'best') {
    rank <- 1
  }
  if(rank == 'worst') {
    if(nrow(data) == 0) {
      return(NA)
    }
    rank <- nrow(data)
  }
  if(nrow(data) < rank) {
    return(NA)
  }
  data[rank, 'hospital']
}

rankall <- function(outcome, rank = 'best') {
  states <- read_states(BEST_CSV)
  res <- sapply(states, function(state) rankhospital(state, outcome, rank), simplify = TRUE, USE.NAMES = FALSE)
  data.frame(hospital=res, state=states)
}