#' Define witch band is NIR
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
define_nir=function(x){
  band_nir=x
  assign("band_nir", band_nir, envir = .GlobalEnv)
}
