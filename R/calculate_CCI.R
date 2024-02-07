#' Calculate CCI index
#'
#' @param r - stars object
#'
#' @return
#' @export
#'
#' @examples calculate_CCI()
calculate_CCI=function(r){
  green<- r[, , , band_green, drop = TRUE]
  red <- r[, , , band_red, drop = TRUE]
  cci <- (green-red)/(green+red)
  assign("cci", cci, envir = .GlobalEnv)
}
