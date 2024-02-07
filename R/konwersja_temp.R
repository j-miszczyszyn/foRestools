#' Konwersja temperatur
#' @description
#' Przelicza temperaturę
#'
#' @param temperatura_f
#'
#' @return przeliczona temperatura
#' @export
#'
#' @examples konwersja_temp(40)

konwersja_temp = function(temperatura_f){
  (temperatura_f - 32) / 1.8
}

