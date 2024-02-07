#' Calculate MSAVI index
#'
#' @param r - stars object
#'
#' @return
#' @export
#'
#' @examples calculate_MSAVI()
calculate_MSAVI=function(r){
  nir <- r[, , , band_nir, drop = TRUE]
  red <- r[, , , band_red, drop = TRUE]
  msavi <- (2 * nir + 1 - sqrt((2 * nir + 1)^2 - 8 * (nir - red))) / 2
  assign("msavi", msavi, envir = .GlobalEnv)
}
