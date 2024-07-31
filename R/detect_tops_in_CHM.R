#' Title
#' Detect Tree Tops in a Canopy Height Model (CHM)
#'
#' This function identifies tree tops in a CHM file using the local maxima filter (LMF) algorithm
#' provided by the lidR package. The identified tree tops can optionally be saved as a shapefile.
#'
#' @param CHM_path The file path of the Canopy Height Model (CHM) TIFF file.
#' @param ws_par The window size parameter for the LMF algorithm in the lidR package,
#' indicating the size of the window used to find local maxima.
#' @param hmin_par The minimum height parameter for the LMF algorithm in the lidR package,
#' which specifies the minimum tree height to be considered.
#' @param output_folder The directory path where the output shapefile should be saved if saving is enabled.
#' @param save_tops A logical value indicating whether to save the detected tree tops as a shapefile.
#' If TRUE, the tree tops are saved; if FALSE, they are not.
#'
#' @return The function does not return a value but outputs a shapefile of tree tops if `save_tops` is TRUE.
#' @export
#'
#' @examples
#' \dontrun{
#' detect_tops_in_CHM("path/to/your/CHM.tif", 5, 10, "path/to/output/folder", TRUE)
#' }
detect_tops_in_CHM <- function(CHM_path, ws_par, hmin_par, output_folder, save_tops) {
  x <- lidR::find_trees(CHM_path, algorithm = lidR::lmf(ws = ws_par, hmin = hmin_par), uniqueness = "incremental")
  name <- basename(CHM_path)
  name <- stringr::str_replace(name, ".tif", "")
  if (save_tops == TRUE) {
    raster::shapefile(x, paste0(output_folder, "/", name, "_TREES.shp"), overwrite = TRUE)
  }
}
