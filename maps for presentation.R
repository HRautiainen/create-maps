### maps for presentations


# WORLD MAPS

# Load packages
pcks <- list("dplyr", 
             "raster", # used for raster data
             "terra", # used for raster data 
             "sf", # used for handling sppatial data (e.g. setting coordinate ref system)
             "ggspatial",
             "tidyverse")

sapply(pcks, require, char = TRUE) 
library(rnaturalearth)



world <- ne_countries(scale = 10)
                       # country = c("Sweden"))
# Check projection
sf::st_crs(world)$proj4string #  unprojected
world <-  st_transform(world, crs ="+proj=utm +zone=33 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")

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
                                        linewidth  = 0.1))


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
