

#' Title
#'
#' @param las_path
#' @param aoi
#' @param folder
#' @param crs_def
#' @param save_las
#'
#' @return
#' @export
#'
#' @examples
cliping_cloud_to_aoi=function(las_path, aoi, folder, crs_def, save_las){
  las=lidR::readLAS(las_path)
  sf::st_crs(aoi)=crs_def
  lidR::crs(las)=crs_def
  las=lidR::clip_roi(las, aoi)
  name=basename(las_path)
  name=str_replace(name, ".las","")
  if  (save_las==TRUE){
    lidR::writeLAS(las, paste0(folder,"/", name,"_AOI.las"))
  }
  return(las)
}


