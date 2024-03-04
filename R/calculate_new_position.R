#' Title
#'
#' @param start_lon 
#' @param start_lat 
#' @param distance 
#' @param bearing 
#'
#' @return
#' @export
#'
#' @examples
calculate_new_position <- function(start_lon, start_lat, distance, bearing) {
  # Obliczenie nowych współrzędnych z użyciem funkcji destPoint() z pakietu geosphere
  new_position <- geosphere::destPoint(c(start_lon, start_lat), bearing, distance)
  # Zwrócenie nowych współrzędnych
  return(list(longitude = new_position[1], latitude = new_position[2]))
}