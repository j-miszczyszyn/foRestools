#' Creating Canopy Height Models and Tree Detection from XY Coordinates
#'
#' @param input_X - X
#' @param input_Y - Y
#' @param point_ID - your unique ID
#' @param d - distanse for buffer
#' @param output_folder - output folder
#' @param input_crs_EPSG - EPSG of your CRS data
#' @param res_par - resolution of CHM
#' @param p2r_par - parametr for p2r() algorithm
#' @param hmin_par - minimal height of tree
#' @param ws_par - window size
#'
#' @return
#' @export
#'
#' @examples CHM_and_TREES_from_XY(15.3029620,52.3876487,1,50, output_folder="D:/01_PROJEKTY/01_Powierzchnie_przyrostowe/Uzupelnienie",4326,0.5,0.15,10,5)

CHM_and_TREES_from_XY=function(input_X, input_Y, point_ID, d, output_folder, input_crs_EPSG, res_par, p2r_par, hmin_par, ws_par ){
  #potrzebne biblioteki
  library(tidyverse, warn.conflicts = FALSE)

  #Stworzenie obiektu sf
    plot_XY <- data.frame(plot_id=point_ID, Y=input_Y, X=input_X)
    plot_XY <- sf::st_as_sf(plot_XY, coords = c("X", "Y"), crs = input_crs_EPSG)
    plot_XY_buffer=plot_XY %>%
      sf::st_buffer(dist = d)

  #Plot powierzchni
    # mapview::mapview(plot_XY_buffer)

  #Pobieranie na dysk lokalny
    plot_XY_dem=rgugik::DEM_request(plot_XY_buffer)
    plot_XY_dem=plot_XY_dem %>%
      filter(format=="LAS")
    rgugik::tile_download(plot_XY_dem, output_folder)

  #Wczytanie LAZ
    plot_XY_las=lidR::readLAS(paste0(output_folder,"/", plot_XY_dem$filename, ".laz"))
    sf::st_crs(plot_XY)

  #Transformacja do PL-1992
    plot_XY=sf::st_transform(plot_XY,2180)
    plot_XY_buffer=sf::st_transform(plot_XY_buffer,2180)
    lidR::crs(plot_XY_las)=2180

  #Przycięcie ALS do AOI
    plot_XY_las=lidR::clip_roi(plot_XY_las, plot_XY_buffer)

  #Normalizacja ALS
    plot_XY_las=lidR::normalize_height(plot_XY_las, algorithm = lidR::tin(), use_class =c(2L))
    plot_XY_CHM=lidR::rasterize_canopy(plot_XY_las, res = res_par, algorithm = lidR::p2r(p2r_par))
    # plot(plot_XY_CHM)

  #Zapis Rastra
    raster::writeRaster(plot_XY_CHM, paste0(output_folder,"/", plot_XY$plot_id,"_CHM.tif"))

  #Detekcja wierzchołków i zapis
    plot_XY_trees=lidR::find_trees(plot_XY_CHM, algorithm = lidR::lmf(ws = ws_par, hmin = hmin_par), uniqueness = "incremental")
    raster::shapefile(plot_XY_trees, paste0(output_folder,"/", plot_XY$plot_id,"_TREES.shp"),overwrite=TRUE)

}


