#' Calculate Copula Distributional Quantities
#'
#' These functions compute distributional quantities (pdf and cdf) of a resolved
#' copula class.
#'
#' @param cop Object of class \code{copula} resolved to one symmetry. See details.
#' @param u,v Values of the first and second copula variables, respectively.
#' Vectorized so that either the lengths should match, or at least one has
#' length 1.
#' @param cpar Vector of value(s) of the canonical copula parameter(s).
#' If unnamed, will use the order of parameters specified in \code{cop}.
#' @export
#' @rdname dcop
dcop <- function(cop, u, v, cpar=NULL) {
    fail_if_unresolved(cop)
    pdf <- cop$dcop
}

#' @export
#' @rdname dcop
pcop <- function(cop, u, v, cpar=NULL) {
    fail_if_unresolved(cop)
    cdf <- cop$pcop
}

fail_if_unresolved <- function(cop) {
    df <- cop$symmspace
    copname <- as.character(rlang::enexpr(cop))
    if (nrow(df) == 0)
        stop(paste("Copula class", copname, "empty. Perhaps too rigorously restricted?"))
    if (nrow(df) > 1)
        stop(paste("Copula class", copname, "contains more than one symmetry. Restrict with `restrict_symm`."))
    NULL
}
