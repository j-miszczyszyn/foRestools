#' Calculate NDVI index
#'
#' @param r - stars object
#'
#' @return
#' @export
#'
#' @examples calculate_NDVI(r)
calculate_NDVI=function(r){
  red=r[, , , band_red, drop = TRUE]
  nir=r[, , , band_nir, drop = TRUE]
  ndvi = (nir - red) / (nir + red)
  assign("ndvi", ndvi, envir = .GlobalEnv)
}
