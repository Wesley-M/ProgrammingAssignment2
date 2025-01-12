## These functions provide a way of caching inverse matrixes

## It receives a matrix object as an argument and returns
## a list of getter and setter methods for both the matrix 
## and its inverse.

makeCacheMatrix <- function(matrix = matrix()) {
    inverse <- NULL
    
    set <- function(new_matrix) {
        matrix <<- new_matrix
        inverse <<- NULL
    }
    
    get <- function() {
        matrix
    }
    
    set_inverse <- function(new_inverse) {
        inverse <<- new_inverse 
    }
    
    get_inverse <- function() {
        inverse
    }
    
    list(set = set, get = get,
         set_inverse = set_inverse,
         get_inverse = get_inverse)
}


## It receives an object (generated by makeCacheMatrix),
## checks if the inverse of that matrix (defined inside that object)
## has already been defined (in which case the inverse is returned) 
## or it calculates the inverse and caches it inside the object.

cacheSolve <- function(x, ...) {
    inverse <- x$get_inverse()
    
    if(!is.null(inverse)) {
        return(inverse)
    }
    
    matrix <- x$get()
    inverse <- solve(matrix, ...)
    
    # Caching the inverse matrix
    x$set_inverse(inverse)
    
    inverse
}


# # Testing the solution

# # Simple benchmark - If you want more precision, see the microbenchmark package.
# benchmark <- function(x, label, ...) {
#     t <- system.time(x(...))
#     print(label)
#     print(t)
# }

# # Really large matrix
# m <- matrix(runif(1000000), 1000, 1000) 
# cm <- makeCacheMatrix(m)

# benchmark(cacheSolve, "Without cache: ", cm)
# benchmark(cacheSolve, "With cache: ", cm)