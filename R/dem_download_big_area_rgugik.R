
#' Title
#'
#' @param x - path to your shapefile
#' @param y - integer of length 1 or 2, number of grid cells in x and y direction (columns, rows)
#'
#' @return
#' @export
#'
#' @examples
dem_download_big_area_rgugik=function(x,y){
  aoi=sf::st_read(x)
  grid=sf::st_make_grid(aoi, n=y)
  aoi=sf::st_intersection(aoi,grid)
  plot(aoi)
  result=data_frame()
  for (i in 1:length(aoi$geometry)) {
    req_df=rgugik::DEM_request(aoi[i,])
    result=dplyr::bind_rows(req_df, result)
  }
  return(result)
  print("This tools is based on https://github.com/kadyb/rgugik")
}
