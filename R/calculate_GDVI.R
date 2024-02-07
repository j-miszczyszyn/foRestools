#' Calculate GDVI index
#'
#' @param r - stars object
#'
#' @return
#' @export
#'
#' @examples calculate_GDVI(r)
calculate_GDVI=function(r){
  green=r[, , , band_green, drop = TRUE]
  nir=r[, , , band_nir, drop = TRUE]
  gdvi = (nir - green)
  assign("gdvi", gdvi, envir = .GlobalEnv)
}
