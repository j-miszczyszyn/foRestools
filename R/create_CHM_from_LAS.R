#' Create Canopy Height Model (CHM) from LAS File
#'
#' This function processes a LAS file to generate a Canopy Height Model (CHM) using the specified resolution
#' and pixel-to-region (p2r) parameters. The resulting CHM can optionally be saved as a TIFF file in the specified output folder.
#' The function uses the `rasterize_canopy` method from the lidR package for rasterizing the LAS point cloud.
#'
#' @param las_path The file path of the LAS file from which the CHM is to be created.
#' @param res_par The resolution parameter for the CHM raster; specifies the size of each pixel in the output raster.
#' @param p2r_par The pixel-to-region parameter used in the p2r algorithm for rasterizing the point cloud.
#' @param save_chm A logical value indicating whether to save the generated CHM as a TIFF file.
#' If TRUE, the CHM is saved; if FALSE, it is not saved.
#' @param output_folder The directory path where the CHM TIFF file should be saved if saving is enabled.
#'
#' @return The function returns NULL invisibly. If `save_chm` is TRUE, the CHM is saved as a TIFF file.
#' @export
#'
#' @examples
#' \dontrun{
#' create_CHM_from_LAS("path/to/your/las_file.las", 0.5, 2, TRUE, "path/to/output/folder")
#' }
create_CHM_from_LAS <- function(las_path, res_par, p2r_par, save_chm, output_folder) {
  # Rasterize the LAS file to create a canopy height model (CHM)
  x <- lidR::rasterize_canopy(las_path, res = res_par, algorithm = lidR::p2r(p2r_par))

  # Create a name for the output file based on the input LAS file name
  name <- basename(las_path)
  name <- stringr::str_replace(name, ".las", "")

  # Save the CHM as a TIFF file if save_chm is TRUE
  if (save_chm) {
    raster::writeRaster(x, paste0(output_folder, "/", name, "_CHM.tif"))
  }
}
