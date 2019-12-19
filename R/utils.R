#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

#' nullify
#' @export
nullify <- function(x, pre = "x = ", suf = ", "){
  ifelse(is.null(x), " ", paste0(pre, x, suf))
}
