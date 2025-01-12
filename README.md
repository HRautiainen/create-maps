# create-maps
GS-VMAS course, Data handling and illustrations

## Objectives
* Become familiar with R packages for processing and simple visualization of vector and raster data 
* Perform common data transformation operations
* Create static maps (with ggplot2) and interactive maps (with mapview)

## Contents
* Explore vector dataset
* Ereference systems and transformations
* Customize maps (ggplot2)
* Explore raster dataset
* Save your map 

### Data used for demo
* Downloaded using "geodata"- and "rnaturalearth"-packages (exercise 1)
* "create-maps/input_data" from lantmäteriet (exercise 2)

### Data availability
* using "rnaturalearth"-package. The "geodata"-package also provide open access data: GADM (https://gadm.org) country boarders, landcover data from  ESA WorldCover etc. 
* raster and vector data downloaded from SLU server gis.slu.se/gisdata, and available from the GET download service at http://maps.slu.se. See GIS support at SLU for more information. 

# set up

#### install and load packages
```{r packages, echo=T, include=FALSE}
install.load::install_load("dplyr", "raster", "sf", "tidyverse", 
                           "maps", "terra", "ggspatial")

#### Load packages
pcks <- list("dplyr",         
             "raster", <br><br># used for raster data        
             "terra",  # used for raster data         
             "sf",     # used for handling spatial vector data         
             "ggspatial",        
             "tidyverse")

sapply(pcks, require, char = TRUE) 

```



