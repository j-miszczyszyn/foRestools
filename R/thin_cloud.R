
#' Title
#'
#' @param folder
#' @param save_las
#' @param las_path
#'
#' @return
#' @export
#'
#' @examples
thin_cloud=function(las_path, folder, save_las){
  las_thined=lidR::readLAS(las_path, filter = "-keep_class 4 5" )
  name=basename(las_path)
  name=str_replace(name, ".las","")
  if  (save_las==TRUE){
    lidR::writeLAS(las_thined, paste0(folder,"/", name,"_THINED.las"))
    }
}

