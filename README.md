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

  

A comparison between the above 4 types of data format is listed:

| Feature | **.xyz** | **.grd (GMT NetCDF)** | **.nc (NetCDF)** | **.asc (ESRI ASCII Grid)** |
|---------|----------|------------------------|------------------|----------------------------|
| **Full Name** | Simple XYZ Point Cloud | GMT Grid Format | Network Common Data Form | ESRI ASCII Grid |
| **Data Type** | Point cloud / Scattered data | Regular grid (2D) | Multi-dimensional array | Regular grid (2D) |
| **Format** | ASCII text | Binary (NetCDF-4) | Binary (NetCDF-3/4) | ASCII text |
| **Human Readable** | ✅ Yes (any text editor) | ❌ No (binary) | ❌ No (binary) | ✅ Yes (any text editor) |
| **File Size** | Large (text) | Small (compressed) | Small to Medium | Very Large (5-10× binary) |
| **Read/Write Speed** | Slow | Fast | Fast | Very Slow |
| **Self-describing** | ❌ No | ✅ Yes (CF-1.7) | ✅ Yes (CF standard) | ⚠️ Limited (only header) |
| **Dimensions** | 2D/3D points | 2D (grid) | 2D, 3D, 4D+ | 2D (grid) |
| **Multiple Variables** | ❌ No | ⚠️ Usually single | ✅ Yes | ❌ No |
| **Time Dimension** | ❌ No | ❌ No | ✅ Yes | ❌ No |
| **Metadata Support** | ❌ None | ✅ Good (units, ranges) | ✅ Excellent | ⚠️ Basic (6-line header) |
| **Missing Data Handling** | ❌ Not defined | ✅ _FillValue attribute | ✅ _FillValue attribute | ✅ NODATA_value |
| **Compression** | ❌ None | ✅ Deflate + shuffle | ✅ Various | ❌ None |
| **Random Access** | ❌ No (sequential) | ✅ Yes | ✅ Yes | ❌ No (sequential) |
| **Software Compatibility** | Universal | GMT, GDAL | GDAL, Python, MATLAB | Universal GIS |
| **Typical File Extension** | `.xyz`, `.txt` | `.grd` | `.nc`, `.grd` | `.asc`, `.txt` |

---


### Abbrevation
**NetCDF**: Network Common Data Form 
**CF**: Climate and Forecast
**CDO**: Climate Data Operators
**NCO**: NetCDF operators
