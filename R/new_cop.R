#' Constructor Function for a Copula
#'
#' @param x List containing the components of a
#' copula object
#' @param variable Type of random variable: "continuous",
#' "discrete", or "mixed".
#' @param ... Other attibutes to add to the object.
#' @param class If making a subclass, specify it here.
new_cop <- function(x, variable, ..., class = character()) {
    distplyr::new_dst(x, variable, ..., class = "cop")
    structure(
    	x,
    	...,
    	class = c(class, "cop")
    )
}

