#' Built-In Bivariate Parametric Copula Families
#'
#' These objects contain information about bivariate
#' parametric copula families.
#'
#' @details
#' Each is a list containing the following components:
#' \describe{
#'   \item{pcop}{cdf}
#'   \item{dcop}{pdf}
#'   \item{logdcop}{log pdf}
#'   \item{pcondcop}{list of length 2 containing the conditional distribution
#'   functions of the first variable given the second, and the second variable
#'   given the first (respectively).}
#' }
#' If symmetries are relevant, the above applies to
#' direction=1, major_axis=1, and minor_axis=1 (whichever are relevant).
#'
#' These objects rely heavily on functions from the package CopulaModel,
#' hence why coperate Depends on this package.
#' @rdname cop
#' @export
cop_frk <- list(
    pcop      = pfrk,
    dcop      = dfrk,
    logdcop   = logdfrk,
    pcondcop  = list(pcondfrk, pcondfrk),
    qcondcop  = list(qcondfrk, qcondfrk),
    cparspace = data.frame(theta=c(-Inf, Inf)),
    symmspace = data.frame(direction  = c(1, -1),
                           major_axis = 0,
                           minor_axis = 0)
)

#' @rdname cop
#' @export
cop_gum <- list(
    pcop      = pgum,
    dcop      = dgum,
    logdcop   = logdgum,
    pcondcop  = list(pcondgum, pcondgum),
    qcondcop  = list(qcondgum, qcondgum),
    cparspace = data.frame(theta=c(-Inf, Inf)),
    symmspace = expand.grid(direction  = c(1, -1),
                            major_axis = c(1, -1),
                            minor_axis = 0)
)

