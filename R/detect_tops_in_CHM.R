
#' Title
#'
#' @param CHM_path
#' @param ws_par
#' @param hmin_par
#' @param output_folder
#' @param save_tops
#'
#' @return
#' @export
#'
#' @examples
detect_tops_in_CHM=function(CHM_path,ws_par,hmin_par, output_folder, save_tops){
x=lidR::find_trees(CHM_path, algorithm = lidR::lmf(ws = ws_par, hmin = hmin_par), uniqueness = "incremental")
name=basename(CHM_path)
name=str_replace(name, ".tif","")
  if  (save_tops==TRUE){
    raster::shapefile(x, paste0(output_folder,"/", name,"_TREES.shp"),overwrite=TRUE)
    }
}
