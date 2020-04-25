#' Make a Gumbel Copula object
#'
#' @param delta Numeric >=1.
#' @export
bicop_gum <- function(delta) {
    if (delta == 1) return(bicop_indep())
    if (delta < 1) stop("Parameter out-of-bounds")
    res <- list(name = "Gumbel",
                parameters = list(delta = delta))
    new_bicop(res, class = "gum")
}


eval_cdf.gum <- function(object, u, v) {
    with(parameters(object), {
        CopulaModel::pgum(u, v, delta)
    })
}


# cdfcond <- function(v, u) CopulaModel::pcondgum(v, u, delta)
# qfcond <- function(p, u) CopulaModel::qcondgum(p, u, delta)
# baseobj <- list(
#     prob   = function(u, v) CopulaModel::dgum(u, v, delta),
#     cdf2g1 = cdfcond,
#     qf2g1  = qfcond,
#     cdf1g2 = cdfcond,
#     qf1g2  = qfcond,
#     rand   = function(n, names = c("u", "v")) {
#         mat <- CopulaModel::rgum(n, delta)
#         df <- as.data.frame(mat)
#         names(df) <- names
#         df
#     }
# )

