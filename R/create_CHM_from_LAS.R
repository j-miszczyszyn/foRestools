
#' Title
#'
#' @param res_par
#' @param p2r_par
#' @param save_chm
#' @param output_folder
#' @param las_path
#'
#' @return
#' @export
#'
#' @examples
create_CHM_from_LAS=function(las_path,res_par,p2r_par,save_chm, output_folder){
  x=lidR::rasterize_canopy(las_path, res = res_par, algorithm = lidR::p2r(p2r_par))
  name=basename(las_path)
  name=str_replace(name, ".las","")
  if  (save_chm==TRUE){
    raster::writeRaster(x, paste0(output_folder,"/",name,"_CHM.tif"))
  }


}
