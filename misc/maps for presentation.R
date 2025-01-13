### maps for presentations


### Make maps in R 

library(sf)
library(geodata) #roads
library(rnaturalearth) # map of swe

library(ggplot2)
library(dplyr)

swe <- ne_countries(country="sweden", scale = 10) %>%
  st_as_sf(.) %>% # as sf object 
  st_crop(., xmin = 17.55, xmax= 17.79, ymin=59.9, ymax=59.8)

roads <- geodata::osm(country="sweden","highways",
                    path=tempdir()) %>%
  st_as_sf(.) %>% # as sf object 
  st_crop(., xmin = 17.55, xmax= 17.79, ymin=59.9, ymax=59.8)

# rivers
rivers110 <- ne_download(scale = 110, type = "rivers_lake_centerlines", category = "physical") %>%
  st_as_sf(.) %>% # as sf object 
  st_crop(., xmin = 17.55, xmax= 17.79, ymin=59.9, ymax=59.8)

plot(rivers110)

ggplot() +
  
  # plot sweden and lakes 
  geom_sf(data = swe,
          aes(geometry = swe$geometry),
          fill= "antiquewhite")+
  
  geom_sf(data = roads,
          aes(geometry = roads$geometry),
          fill= "darkgrey")

geom_sf(data = rivers110,
        aes(geometry = rivers110$geometry),
        fill="lightblue")

ggsave("uppsala_roads.png", width = 8, height = 6, dpi = 400)

# WORLD MAPS

# Load packages
pcks <- list("dplyr", 
             "raster", # used for raster data
             "terra", # used for raster data 
             "sf", # used for handling sppatial data (e.g. setting coordinate ref system)
             "ggspatial", # for creating maps in ggplot 
             "tidyverse")

sapply(pcks, require, char = TRUE) 
library(rnaturalearth)



world <- ne_countries(scale = 10)
                       # country = c("Sweden"))
# Check projection
sf::st_crs(world)$proj4string #  unprojected
# world <-  st_transform(world, crs ="+proj=utm +zone=33 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")

world <-  st_transform(world, crs ="+proj=laea +x_0=0 + y_0=0 +lon_0=0 +lat_0=0")






## plot it 

library(ggspatial)

ggplot() +
  
  # plot sweden and lakes 
  geom_sf(aes(geometry = world$geometry)) + # geom_sf() for vector data 
  geom_sf(data = world,
          aes(geometry = world$geometry),
          fill= "antiquewhite")+

  # add grid lines 
  theme(panel.grid.major = element_line(color = gray(.5), 
                                        linetype = "dashed", 
                                        linewidth  = 0.1), 
        panel.background = element_rect(fill = "white")) 


ggsave("output/figx.png", width = 8, height = 6, dpi = 400)

#### RAST VECT


library(raster)
library(geodata)
library(dplyr)



# elevation -------


swe <- gadm("Sweden", level=1, path=tempdir())%>% 
  crop(., extent(14, 25, 62, 69))
swe_3006 <- terra::project(swe, "+proj=utm +zone=33 +ellps=GRS80 +units=m +no_defs")

plot(swe_3006)
png("vector.png", width = 24, height = 13.5, units = "cm", res = 400)

plot(swe_3006, col=over.col(100))
dev.off()

dem.c1 <- geodata::elevation_30s(country="SWE", 
                                 path=tempdir()) %>% 
  crop(., extent(14, 25, 62, 69))

dem.c1 <- terra::project(dem.c1, "+proj=utm +zone=33 +ellps=GRS80 +units=m +no_defs")

plot(dem.c1)

over.col <- colorRampPalette(c("white", "black"))


# save rast map
png("raster.png", width = 24, height = 13.5, units = "cm", res = 400)

plot(dem.c1, col=over.col(100))
dev.off()




# save rast map
png("raster_col.png", width = 24, height = 13.5, units = "cm", res = 400)

plot(dem.c1)
dev.off()


str(dem.c1$SWE_elv_msk)






### ocean depth 

# To avoid repeatedly downloading the same data, open the .Rprofile file by running
usethis::edit_r_profile()

# and add

.ggOceanMapsenv <- new.env()
.ggOceanMapsenv$datapath <- '~/ggOceanMapsLargeData' # you can use a different directory if you want
library(ggOceanMaps)
ocean <- basemap(limits = c(-30, 30, 50, 80),
        bathymetry = TRUE,
        glaciers = TRUE)
ocean


swe <- ggplot2::map_data("world2", region ="sweden")
unique(swe$subregion)
head(swe)
plot(swe)

library(tmap)

