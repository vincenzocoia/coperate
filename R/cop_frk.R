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
    symmspace = expand.grid(family     = "Frank",
                            direction  = c(1, -1),
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
    symmspace = expand.grid(family     = "Gumbel",
                            direction  = c(1, -1),
                            major_axis = c(1, -1),
                            minor_axis = 0)
)

## Global lists

all_symms <- rbind(cop_frk$symmspace, cop_gum$symmspace)

fam_properties <- data.frame(
    family=c("Frank", "Gumbel"),
    abbr_name=c("frk", "gum"),
    upper_tail_dep=c(0,1),
    lower_tail_dep=c(0,0))

fam_cparspace <- list(
    Frank = data.frame(theta=c(-Inf,Inf)),
    Gumbel= data.frame(theta=c(1,Inf)),
    IG    = data.frame(theta=c(0,Inf), k=c(1,Inf))
)
