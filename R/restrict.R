#' Restrict a copula family
#' @export
restrict <- function(cop, dependence=NULL) {
    if (!is.null(dependence)) {
        if (tolower(dependence)=="positive") {
            cop$symmspace <- subset(cop$symmspace, dependence==1)
        } else if (tolower(dependence)=="negative") {
            cop$symmspace <- subset(cop$symmspace, dependence==-1)
        }
    }
    cop
}
