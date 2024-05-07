#' Title
#'
#' @param folder_path
#' @param ws_par
#' @param hmin_par
#' @param crs_def
#' @param output_folder
#' @param save_tops
#' @param save_SHP
#'
#' @return
#' @export
#'
#' @examples
tops_in_folder_to_shp=function(folder_path,ws_par,hmin_par,crs_def, output_folder, save_tops, save_SHP){

l_CHM=list.files(folder_path, full.names = T, pattern="\\.tif$")
trees_finded=data.frame()

for (i in 1:length(l_CHM)) {
  tryCatch({
    r=raster(l_CHM[i])
    t=detect_tops_in_CHM(CHM_path=folder_path,ws_par,hmin_par, output_folder, save_tops)
    temp=data.frame(t)
    temp$ID_NUMBER=1+i

    # Dodaj wyniki do istniejącego obiektu typu sf
    trees_finded <- rbind(trees_finded, temp)
  }, error = function(e) {
    # Przechwyć błąd, ale kontynuuj działanie pętli
    cat("Błąd w iteracji", i, ":", conditionMessage(e), "\n")
  })
}

trees_finded=st_as_sf(trees_finded, coords = c("coords.x1","coords.x2"))
st_crs(trees_finded)=crs_def
 if( save_SHP==TRUE){
  st_write(trees_finded,paste0(output_folder,"ALL_TTOPS.shp"), overwrite=T)
 }
return(trees_finded)
}
