#' Constructor Function for a Bivariate Copula
#' @param baseobj List with distribution quantities.
new_bicop <- function(baseobj) {
    structure(baseobj, class = "bicop")
}

