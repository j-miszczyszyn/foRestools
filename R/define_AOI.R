#' Define AOI by setting path to the Shapefile
#'
#' @param x - Path to the Shapefile
#'
#' @return
#' @export
#'
#' @examples  define_AOI("D:/BDL_Rezerwat_AOI.shp")
define_AOI=function(x){
  aoi=sf::st_read(x)
  assign("aoi",  aoi, envir = .GlobalEnv)
}
