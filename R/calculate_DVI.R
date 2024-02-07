#' Calculate DVI index
#'
#' @param r - stars object
#'
#' @return
#' @export
#'
#' @examples calculate_DVI(r)
calculate_DVI=function(r){
  red=r[, , , band_red, drop = TRUE]
  nir=r[, , , band_nir, drop = TRUE]
  dvi = (nir - red)
  assign("dvi", dvi, envir = .GlobalEnv)
}
