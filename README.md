# GMT_tools
The The Generic Mapping Tools (GMT) is very popular and useful for gelogist and geophysicst in plotting maps. 
In this project, I put some tools I wrote with matalb, powershell (adaptable for windows users) and bash. There 
are different formats of morphological data file. In this manual I gave a quick introduction on these formats. 


## Input Data Files  
### .xyz format

`.xyz` is kind of point cloud file, with three colombs which are X, Y, and Z. The X, Y, and Z are normally as
longitude, latitude and elevation. X and Y can also be the corrdinate as horizontal and vertical. The colombs
are seperated by splace or TAB. To plot the `.xyz` file with the GMT, a grid file (`.grd`) is the prerequisite.
The `.grd` file can be generated with the `gmt surface`. `gmt grdgradient` is optional and `gmt grdimage` can 
plot the `.grd` file generated from the `.xyz` file. There is also an option `gmt xyz2grd`, 

### .grd format  

`.grd` is a type of grid data file, following the NetCDF standard (CF 1.7 in the GMT 6). `gmt grdinfo` can check 
the file information of a `.grd` file. 

### .nc format

`.nc` is a type if NetCDF standard file, supporting high dimensional dataset with more variables. The command 
dealing with the `.grd` files can also applied on the `.nc` file. The `.nc` file can be cut with `gmt grdcut` 
in space or CDO toolbox (need to be installed) like `cdo seldate` in time. The `.nc` files can also be dealed 
with the NCO toolbox.

### .asc format

`.asc` is a text-based raster data storage standard, usually referring to ESRI Ascii grid format. The header of
`.asc` files including the `ncols`, `nrows`, `xllcorner`, `yllcorner`, `cellsize` and `NODATA_value`. Afterward 
is the grid data, list by lines from top to the bottom. It should be noted that the `xllcorner` and `yllcorner` 
represnts the center point at the centre of left-bottom corner grid (or pixel). The defrined centre may be 
different from other file format standards. The `.asc` file only support 2-Dimensional data. In GMT, the above 
tools can support `.asc` format such as `gmt grd2xyz` and `gmt grdconvert`. The `*.asc=` can be selected as
`ef`(ESRI Ascii Grid), `gd` (GMT default) or `ff` (Golden Software Surfer). If the direction of the data is 
flipped, can be corrected by the `gmt grdflip`. 




### Abbrevation
**NetCDF**: Network Common Data Form 
**CF**: Climate and Forecast
**CDO**: Climate Data Operators
**NCO**: NetCDF operators
