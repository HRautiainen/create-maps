### maps for presentations


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
