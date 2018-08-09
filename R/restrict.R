#' Restrict a copula family
#'
#' Restricts the parameter space of a copula class.
#'
#' @param cop Object of class \code{copula}.
#' @param ... Logical statement to perform restriction
#'
#' @details
#' Names of the canonical copula parameters
#'
#' @export
restrict_symm <- function(cop, ...) {
    df <- cop$symmspace
    dots <- rlang::enexprs(...)
    nd <- length(dots)
    if (nd == 0) return(df)
    rows <- eval(dots[[1]], df)
    if (nd > 1) for (i in 2:nd) rows <- rows & eval(dots[[i]], df)
    cop$symmspace <- df
}

#' @export
restrict_cpar <- function(cop, ...){
    dots <- rlang::enexprs(...)
    cop$cparspace <- c(cop$cparspace, dots)
    cop
}


