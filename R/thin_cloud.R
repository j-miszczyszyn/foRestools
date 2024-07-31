#' Title
#' Thin Point Cloud by Keeping Specific Classes
#'
#' This function reads a LAS file, filters it to retain only specified classes of points (e.g., vegetation),
#' and optionally saves the thinned point cloud to a new LAS file. The function specifically keeps points
#' classified as 4 (medium vegetation) and 5 (high vegetation) by default.
#'
#' @param las_path The file path of the LAS file to be thinned.
#' @param folder The directory path where the thinned LAS file should be saved, if saving is enabled.
#' @param save_las A logical value indicating whether to save the thinned point cloud as a new LAS file.
#' If TRUE, the thinned point cloud is saved; if FALSE, it is not saved.
#'
#' @details This function does not return a value but outputs a LAS file of the thinned point cloud if `save_las` is TRUE.
#' @export
#'
#' @examples
#' \dontrun{
#' thin_cloud("path/to/your/point_cloud.las", "path/to/output/folder", TRUE)
#' }
thin_cloud <- function(las_path, folder, save_las) {
  las_thined <- lidR::readLAS(las_path, filter = "-keep_class 4 5")
  name <- basename(las_path)
  name <- stringr::str_replace(name, ".las", "")
  if (save_las == TRUE) {
    lidR::writeLAS(las_thined, paste0(folder, "/", name, "_THINED.las"))
  }
}
