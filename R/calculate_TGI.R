#' Calculate TGI index
#'
#' @param r - stars object
#'
#' @return
#' @export
#'
#' @examples calculate_TGI()
calculate_TGI=function(r){
  blue=r[, , , band_blue, drop = TRUE]
  green=r[, , , band_green, drop = TRUE]
  red=r[, , , band_red, drop = TRUE]
  tgi = green -(0.39*red)-(0.61*blue)
  assign("tgi", tgi, envir = .GlobalEnv)
}
