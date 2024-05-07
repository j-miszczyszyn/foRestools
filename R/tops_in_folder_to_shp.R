#' Title
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
