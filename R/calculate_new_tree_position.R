#' Calculate New Tree Positions
#'
#' This function calculates the coordinates of trees based on their azimuth and distance from the plot center, and optionally saves the results in `sf` format.
#'
#' @param plot The plot number for which tree positions are calculated (numeric).
#' @param save Logical (`TRUE` or `FALSE`), indicating whether to save the results to a SHP file.
#' @param crs Coordinate reference system in EPSG format (default is 2180, which is the PUWG 1992 system for Poland).
#' @param dataset Path to the CSV file containing tree data with columns: `plot_id`, `azimuth`, `distance`.
#' @param plot_center_x The x-coordinate of the plot center (numeric).
#' @param plot_center_y The y-coordinate of the plot center (numeric).
#'
#' @return A spatial data frame (sf object) with calculated tree positions.
#' @export
#'
#' @examples
#' \dontrun{
#' calculate_new_tree_position(
#'   plot = 1,
#'   save = TRUE,
#'   crs = 2180,
#'   dataset = "trees_data.csv",
#'   plot_center_x = 500000,
#'   plot_center_y = 400000
#' )
#' }
calculate_new_tree_position <- function(plot, save, crs, dataset, plot_center_x, plot_center_y) {
  # Load data
  x <- read.csv2(dataset)

  # Filter data for the selected plot
  x <- dplyr::filter(x, plot_id == plot)

  # Convert azimuth and distance to Cartesian coordinates
  x <- dplyr::mutate(x,
                     x_pos = plot_center_x + distance * sin(azimuth * pi / 180),
                     y_pos = plot_center_y + distance * cos(azimuth * pi / 180)
  )

  # Create an sf object with the specified CRS (EPSG: 2180)
  trees_sf <- sf::st_as_sf(x, coords = c("x_pos", "y_pos"), crs = crs)

  # Save the result if save == TRUE
  if (save) {
    sf::st_write(trees_sf, paste0("trees_plot_", plot, ".shp"))
  }

  return(trees_sf)
}

