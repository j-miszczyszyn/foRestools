#' Process CHM Files in Folder and Optionally Save Tree Tops to Shapefile
#'
#' This function processes all Canopy Height Model (CHM) TIFF files in a specified folder, detects tree tops using
#' the `detect_tops_in_CHM` function, and optionally saves the results as a shapefile. Each tree top detection
#' is assigned an ID number and the results are combined into a spatial dataframe.
#'
#' @param folder_path The directory path containing the CHM TIFF files.
#' @param ws_par The window size parameter for the local maxima filter (LMF) algorithm in the lidR package.
#' @param hmin_par The minimum height parameter for the LMF algorithm.
#' @param crs_def The coordinate reference system (CRS) definition to be applied to the output spatial dataframe.
#' @param output_folder The directory path where the output shapefile should be saved if saving is enabled.
#' @param save_tops A logical value indicating whether to save the detected tree tops data frame during processing.
#' @param save_SHP A logical value indicating whether to save the final spatial dataframe as a shapefile.
#'
#' @return Returns a spatial dataframe of detected tree tops with ID numbers. If `save_SHP` is TRUE,
#' a shapefile will also be generated.
#' @export
#' @examples
#' \dontrun{
#' tops_in_folder_to_shp("path/to/your/folder", 5, 2, 4326, "path/to/output/folder", TRUE, TRUE)}
tops_in_folder_to_shp <- function(folder_path, ws_par, hmin_par, crs_def, output_folder, save_tops, save_SHP) {
  # List all CHM TIFF files in the specified folder
  l_CHM <- list.files(folder_path, full.names = TRUE, pattern = "\\.tif$")
  trees_finded <- data.frame()

  # Process each CHM file
  for (i in seq_along(l_CHM)) {
    tryCatch({
      r <- raster::raster(l_CHM[i])
      t <-foRestools::detect_tops_in_CHM(CHM_path = l_CHM[i], ws_par = ws_par, hmin_par = hmin_par, output_folder = output_folder, save_tops = save_tops)
      temp <- data.frame(t)
      temp$ID_NUMBER <- 1 + i

      # Append results to the existing dataframe
      trees_finded <- rbind(trees_finded, temp)
    }, error = function(e) {
      # Capture the error but continue the loop
      cat("Error in iteration", i, ":", conditionMessage(e), "\n")
    })
  }

  # Convert the dataframe to an sf object
  trees_finded <- sf::st_as_sf(trees_finded, coords = c("coords.x1", "coords.x2"))
  sf::st_crs(trees_finded) <- crs_def

  # Save the spatial dataframe as a shapefile if save_SHP is TRUE
  if (save_SHP) {
    sf::st_write(trees_finded, paste0(output_folder, "/ALL_TTOPS.shp"), overwrite = TRUE)
  }

  return(trees_finded)
}
