#' Copula parameter out of bounds
#'
#' Generate a message stating that a copula
#' parameter is out of bounds.
#'
#' @param cpar Out of bounds copula parameter. This is first
#' quoted to capture the copula parameter name.
#' @return A string, intended to be used within the stop() function.
cpar_is_oob <- function(cpar) {
    arg <- rlang::enquo(cpar)
    name <- rlang::as_name(arg)
    paste0("The supplied value ",
           rlang::eval_tidy(arg),
           " for copula parameter '",
           name,
           "' is out of bounds.")
}
