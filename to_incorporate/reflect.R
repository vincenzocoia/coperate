#' Reflect all members of a copula family
#' @export
reflect <- function(cop, axes=c(1,2)) {
    if (1 %in% axes){
        cop$symmspace$dependence <- cop$symmspace$dependence * (-1)
        cop$symmspace$minor_axis <- cop$symmspace$minor_axis * (-1)
    }
    if (2 %in% axes){
        cop$symmspace$dependence <- cop$symmspace$dependence * (-1)
        cop$symmspace$major_axis <- cop$symmspace$major_axis * (-1)
    }
    cop
}
