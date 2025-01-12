# create-maps
GS-VMAS course, Data handling and illustrations


# set up
##### setwd("~/.../create-maps")

#### install packages
##### install.load::install_load("dplyr", "raster", "sf", "tidyverse", 
#####                             "maps", "terra", "ggspatial")

# Load packages
pcks <- list("dplyr", 
             "raster", # used for raster data
             "terra",  # used for raster data 
             "sf",     # used for handling spatial vector data 
             "ggspatial",
             "tidyverse")

sapply(pcks, require, char = TRUE) 





