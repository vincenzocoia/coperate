#' Make a Gumbel Copula object
#'
#' @param cpar1 Numeric >=1.
#' @export
bicop_gum <- function(cpar1) {
    if (cpar1 == 1) return(bicop_indep())
    if (cpar1 < 1) stop(cpar_is_oob(cpar1))
    cdfcond <- function(v, u) CopulaModel::pcondgum(v, u, cpar1)
    qfcond <- function(p, u) CopulaModel::qcondgum(p, u, cpar1)
    baseobj <- list(
        cdf    = function(u, v) CopulaModel::pgum(u, v, cpar1),
        prob   = function(u, v) CopulaModel::dgum(u, v, cpar1),
        cdf2g1 = cdfcond,
        qf2g1  = qfcond,
        cdf1g2 = cdfcond,
        qf1g2  = qfcond,
        rand   = function(n, names = c("u", "v")) {
            mat <- CopulaModel::rgum(n, cpar1)
            df <- as.data.frame(mat)
            names(df) <- names
            df
        }
    )
    new_bicop(baseobj)
}
