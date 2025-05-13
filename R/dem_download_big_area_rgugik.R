#' Download DEM for a Large Area from RGUGIK
#'
#' This function downloads Digital Elevation Model (DEM) data for a large area specified by a shapefile.
#' The area is divided into a grid of smaller sections based on a specified cell size (in meters)
#' to manage the request size. The DEM data for each section is requested from the RGUGIK service
#' and combined into a single dataframe.
#'
#' @param x The file path to the shapefile defining the area of interest.
#' @param y The cell size (in meters) used to divide the area into a grid. Default is 316.23 (approx. 10 ha cells).
#'
#' @return A dataframe containing the DEM data for the specified area.
#' @export
#'
#' @examples
#' \dontrun{
#' result <- dem_download_big_area_rgugik("path/to/your/shapefile.shp")
#' result2 <- dem_download_big_area_rgugik("path/to/your/shapefile.shp", y = 500)
#' print(result)
#' }
dem_download_big_area_rgugik <- function(x, y = 316.23) {
  # Read the shapefile defining the area of interest
  aoi <- sf::st_read(x)
  aoi <- sf::st_buffer(aoi, dist = 100)
  poland_geom <- rgugik::borders_get()
  aoi <- sf::st_intersection(aoi, poland_geom)

  # Create a grid over the area of interest
  grid <- sf::st_make_grid(aoi, cellsize = y)
  aoi <- sf::st_intersection(aoi, grid)

  # Plot the area of interest divided by the grid
  plot(aoi)

  # Initialize an empty dataframe to store the results
  result <- data.frame()

  # Loop through each section of the grid and request DEM data
  for (i in seq_len(nrow(aoi))) {
    req_df <- rgugik::DEM_request(aoi[i, ])
    result <- dplyr::bind_rows(result, req_df)
  }

  # Print a message indicating the tool is based on the rgugik package
  print("This tool is based on https://github.com/kadyb/rgugik")

  # Return the combined DEM data
  return(result)
}
