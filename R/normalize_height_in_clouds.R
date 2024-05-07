
#' Title
#'
#' @param las_path
#' @param folder
#' @param save_las
#'
#' @return
#' @export
#'
#' @examples
normalize_height_in_clouds=function(las_path, folder, save_las){
  las=lidR::readLAS(las_path)
  las_norm=lidR::normalize_height(las, lidR::tin(),use_class =c(2L) )
  name=basename(las_path)
  name=str_replace(name, ".las","")
  if  (save_las==TRUE){
   lidR::writeLAS(las_norm, paste0(folder,"/", name,"_NORM.las"))
  }
return(las_norm)
  }
