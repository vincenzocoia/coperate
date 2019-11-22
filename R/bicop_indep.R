#' Make an Independence Copula object
#' @export
bicop_indep <- function() {
    baseobj <- list(
        cdf    = function(u, v) stats::punif(u) * stats::punif(v),
        prob   = function(u, v) stats::dunif(u) * stats::dunif(v),
        cdf2g1 = function(v, u) stats::punif(v),
        qf2g1  = function(p, u) stats::qunif(p),
        cdf1g2 = function(u, v) stats::punif(u),
        qf1g2  = function(p, v) stats::qunif(p),
        rand   = function(n, names = c("u", "v")) {
            u <- stats::runif(n)
            v <- stats::runif(n)
            res <- data.frame(u, v)
            names(res <- names)
            res
        }
    )
    new_bicop(baseobj)
}
