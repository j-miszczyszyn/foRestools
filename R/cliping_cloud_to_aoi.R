#' Title
#' Clip LiDAR Point Cloud to Area of Interest (AOI)
#'
#' This function reads a LAS file, assigns a new coordinate reference system (CRS) to both the point cloud and the AOI,
#' clips the point cloud to the AOI, and optionally saves the clipped point cloud to a new LAS file.
#'
#' @param las_path Path to the input LAS file containing the point cloud data.
#' @param aoi An sf object defining the Area of Interest to which the point cloud will be clipped.
#' @param folder Path to the folder where the output LAS file will be saved, if saving is enabled.
#' @param crs_def Coordinate Reference System definition to be applied to both the point cloud and the AOI.
#' @param save_las Logical flag indicating whether to save the clipped point cloud to a new LAS file. Set to TRUE to save.
#'
#' @return Returns the clipped point cloud as a lidR las object.
#' @export
#'
#' @examples
#' \dontrun{
#' # Assuming 'path_to_las', 'aoi_sf', 'output_folder', and 'crs_definition' are predefined:
#' clipped_las <- cliping_cloud_to_aoi("path_to_las", aoi_sf, "output_folder", "crs_definition", TRUE) }

cliping_cloud_to_aoi=function(las_path, aoi, folder, crs_def, save_las){
  las=lidR::readLAS(las_path)
  sf::st_crs(aoi)=crs_def
  lidR::crs(las)=crs_def
  las=lidR::clip_roi(las, aoi)
  name=basename(las_path)
  name=stringr::str_replace(name, ".las","")
  if  (save_las==TRUE){
    lidR::writeLAS(las, paste0(folder,"/", name,"_AOI.las"))
  }
  return(las)
}


