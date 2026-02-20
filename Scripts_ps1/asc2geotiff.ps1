# Input ASCII data file path
$ASC = "*.asc"

# Output GeoTIFF file path
$GEOTIFF = "*.tif"

# Generated GeoTIFF
# -scale with no parameters → GDAL automatically performs linear mapping based on the input raster's min/max values
# -a_srs EPSG:4326 → Embed projection information
# -a_nodata -9999 → Preserve NODATA

#gdal_translate -of GTiff -scale -a_srs EPSG:4326 -a_nodata -9999 $ASC $GEOTIFF

# Also generate the TFW file
gdal_translate -of GTiff -co TFW=YES -scale -a_srs EPSG:4326 -a_nodata -9999 $ASC $GEOTIFF

Write-Host "✅ GeoTIFF Generated：$GEOTIFF"

# Output projected GeoTIFF file path, for example: UTM 33N
$GEOTIFF_UTM = "*_utm33n.tif"

gdalwarp -overwrite -co TFW=YES -t_srs EPSG:32633 -r bilinear -dstnodata -9999 $GEOTIFF $GEOTIFF_UTM
Write-Host "✅ Projected to UTM33N：$GEOTIFF_UTM Generated"
