#' Title
#'
#' @param x
#' @param y
#'
#' @return
#' @export
#'
#' @examples
dem_download_big_area_rgugik <- function(x, y) {
  aoi <- sf::st_read(x)
  grid <- sf::st_make_grid(aoi, n = y)
  aoi <- sf::st_intersection(aoi, grid)
  plot(aoi)
  result <- data.frame()
  for (i in seq_len(nrow(aoi))) {
    req_df <- rgugik::DEM_request(aoi[i, ])
    result <- dplyr::bind_rows(result, req_df)
  }
  print("This tools is based on https://github.com/kadyb/rgugik")
  return(result)
}
