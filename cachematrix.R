## These functions cache the inverse of a matrix. 
## The inverse of a matrix is cached to prevent having to compute it repeatedly as matrix inversion is usually a costly computation 

## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(uninvertedMatrix = matrix()) {
        
        # initialize matrix
        invertedMatrix <- NULL
        
        # set uninverted matrix
        set <- function(y) {
                uninvertedMatrix <<- y
                invertedMatrix <<- NULL
        }
        
        # get the uninverted matrix
        get <- function() uninvertedMatrix
        
        # set the inverted matrix
        setinverse <- function(solve) invertedMatrix <<- solve
        
        # get the inverted matrix
        getinverse <- function() invertedMatrix
        
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}


## This function computes the inverse of the special "matrix" returned by `makeCacheMatrix` above. 
## If the inverse has already been calculated (and the matrix has not changed), then `cacheSolve` retrieves the inverse from the cache.

cacheSolve <- function(uninvertedMatrix, ...) {
        
        ## Get inverted matrix and return if present
        invertedMatrix <- uninvertedMatrix$getinverse()
        
        if(!is.null(invertedMatrix)) {
                message("getting cached data")
                return(invertedMatrix)
        }
        
        # Otherwise get uninverted matrix and use solve to invert it, then set it
        data <- uninvertedMatrix$get()
        
        invertedMatrix <- solve(data)
        
        uninvertedMatrix$setinverse(invertedMatrix)
        
        # Return inverted matrix after solving and setting it
        invertedMatrix
}
