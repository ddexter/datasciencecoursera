# Matrix object that stores a standard N x N invertible matrix and is capable of
# caching the inverse of the matrix 
makeCacheMatrix <- function(m = matrix()) {
  m_inverse <- NULL
  
  # Set a new matrix and clear the cached inverse
  set <- function(m2) {
    m <<- m2
    m_inverse <<- NULL
  }
  
  # Get the matrix
  get <- function() m
    
  # Generic getter/setters for the matrix inverse
  set_inverse <- function(inverse) m_inverse <<- inverse
  get_inverse <- function() m_inverse
  
  list(set = set,
       get = get,
       set_inverse = set_inverse,
       get_inverse = get_inverse)
}

# Gets the inverse of a matrix stored in special_m.  The inverse will only
# be computed once
cacheSolve <- function(special_m) {
  m_inverse <- special_m$get_inverse()
  # Return cached matrix inverse
  if(!is.null(m_inverse)) {
    message("Getting cached matrix inverse")
    return(m_inverse)
  }
  # Cached value doesn't exist, must be computed for first time
  m <- special_m$get()
  m_inverse <- solve(m)
  # Store inverse
  special_m$set_inverse(m_inverse)
  # Return inverse
  m_inverse
}