#' Title
#' Normalize Height of LiDAR Point Cloud
#'
#' This function reads a LAS file, normalizes the heights of the point cloud using a TIN surface,
#' and optionally saves the normalized point cloud to a new LAS file. Only the points classified as
#' ground (class = 2) are used to compute the TIN surface.
#'
#' @param las_path Path to the input LAS file containing the point cloud data.
#' @param folder Path to the folder where the output LAS file will be saved, if saving is enabled.
#' @param save_las Logical flag indicating whether to save the normalized point cloud to a new LAS file. Set to TRUE to save.
#'
#' @return las_norm
#' @export
#'
#' @examples
#' \dontrun{
#' # Assuming 'path_to_las' and 'output_folder' are predefined:
#' normalized_las <- normalize_height_in_clouds("path_to_las", "output_folder", TRUE)
#' }
normalize_height_in_clouds <- function(las_path, folder, save_las) {
  las <- lidR::readLAS(las_path)
  las_norm <- lidR::normalize_height(las, lidR::tin(), use_class = c(2L))
  name <- basename(las_path)
  name <- stringr::str_replace(name, ".las", "")
  if (save_las == TRUE) {
    lidR::writeLAS(las_norm, paste0(folder, "/", name, "_NORM.las"))
  }
  return(las_norm)
}
