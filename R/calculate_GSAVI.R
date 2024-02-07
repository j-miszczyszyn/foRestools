#' Calculate GSAVI index
#'
#' @param r - stars object
#'
#' @return
#' @export
#'
#' @examples calculate_GSAVI()
calculate_GSAVI=function(r){
  green=r[, , , band_green, drop = TRUE]
  red=r[, , , band_red, drop = TRUE]
  nir=r[, , , band_nir, drop = TRUE]
  gsavi = (nir - green)/ (nir + green+1)*1.5
  assign("gsavi", gsavi, envir = .GlobalEnv)
}
