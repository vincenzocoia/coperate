#' Restrict a copula family
#'
#' @details
#' Other identifiers you can specify besides those listed in the arguments:
#'
#' - \code{cpar}, corresponding to the canonical copula parameters. For
#'    example, theta < 10.
#'
#' @export
restrict <- function(cop, dependence=NULL, ...) {
    if (!is.null(dependence)) {
        if (tolower(dependence)=="positive") {
            cop$symmspace <- subset(cop$symmspace, dependence==1)
        } else if (tolower(dependence)=="negative") {
            cop$symmspace <- subset(cop$symmspace, dependence==-1)
        }
    }
    # If cpar is in elipses:
    cop$cparspace
}

use_vignette("copula_families")
