#' Calculate New Position
#'
#' This function calculates the new geographical position given a starting longitude, latitude, distance, and bearing.
#'
#' @param start_lon The starting longitude in decimal degrees.
#' @param start_lat The starting latitude in decimal degrees.
#' @param distance The distance to travel from the starting point, in meters.
#' @param bearing The direction of travel in degrees from north (clockwise).
#'
#' @return A list containing the new longitude and latitude in decimal degrees.
#' @export
#'
#'
calculate_new_position <- function(start_lon, start_lat, distance, bearing) {
  # Obliczenie nowych współrzędnych z użyciem funkcji destPoint() z pakietu geosphere
  new_position <- geosphere::destPoint(c(start_lon, start_lat), bearing, distance)
  # Zwrócenie nowych współrzędnych
  return(list(longitude = new_position[1], latitude = new_position[2]))
}
