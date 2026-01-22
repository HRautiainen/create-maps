# create-maps
GS-VMAS course, Data handling and illustrations

## Objectives
* Become familiar with R packages for processing and simple visualization of vector and raster data 
* Perform common data transformation operations
* Create static maps (with ggplot2)
* Become familiar with interactive maps 

## Contents
* Explore vector and raster datasets
* Reference systems and transformations
* Customize maps (ggplot2) 
* Save your map
* Examples interactive maps (mapview) 

### Data used for demo
* "create-maps/input_data" using "geodata"- and "rnaturalearth"-packages (exercise 1)
* "create-maps/input_data" from lantmäteriet (optional: exercise 3)

### Data availability
* using "rnaturalearth"-package. The "geodata"-package also provide open access data: GADM (https://gadm.org) country boarders, landcover data from  ESA WorldCover etc. 
* raster and vector data downloaded from SLU server gis.slu.se/gisdata, and available from the GET download service at http://maps.slu.se. See GIS support at SLU for more information. 

# set up

#### install and load packages
```{r packages, echo=T, include=FALSE}

#### load; install missing packages
install.load::install_load("dplyr",
                           "raster",
                           "ggplot2",
                           "terra",
                           "sf",
                           "ggspatial",
                           "tidyverse")


#### or load packages
pcks <- list("dplyr",         
             "raster", # used for raster data        
             "terra",  # used for raster data         
             "sf",     # used for handling spatial vector data         
             "ggspatial",        
             "tidyverse")

sapply(pcks, require, char = TRUE) 

```



