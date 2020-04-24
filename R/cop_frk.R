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
#' dependence=1, major_axis=1, and minor_axis=1 (whichever are relevant).
#'
#' Important! "Major Axis" is 1 if there's more mass on the right.
#' This is because I'd like to think of the copula in terms of its
#' principal component axes.
#'
#' Similarly, "Minor Axis" is 1 if there's more mass on the upper part of
#' the copula.
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
    cparspace = rlang::exprs(theta = -Inf < theta && theta<Inf),
    symmspace = expand.grid(family     = "Frank",
                            dependence = c(1, -1),
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
    cparspace = rlang::exprs(theta = -Inf < theta && theta<Inf),
    symmspace = expand.grid(family     = "Gumbel",
                            dependence = c(1, -1),
                            major_axis = c(1, -1),
                            minor_axis = 0)
)

#' @rdname cop
#' @export
cop_gau <- list(
    pcop      = pbvncop,
    dcop      = dbvncop,
    logdcop   = logdbvncop,
    pcondcop  = list(pcondbvncop, pcondbvncop),
    qcondcop  = list(qcondbvncop, qcondbvncop),
    cparspace = rlang::exprs(rho = 0 < rho && rho < 1),
    symmspace = expand.grid(family     = "Gaussian",
                            dependence = c(1, -1),
                            major_axis = 0,
                            minor_axis = 0)
)
