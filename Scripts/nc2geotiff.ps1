# Convert NetCDF data file into geotiff image
# Rxample Region: Tyrrhenian Sea
# Read Data
$NC = "gebco_2024_n44.0_s37.0_w8.0_e17.0.nc"

# Output data
$GEOTIFF = "gebco_geo.tif"

# Directly generate WGS84 (EPSG:4326) GeoTIFF
# -32767 suggests NoDATA cell because Int16 ranges -32768 ~ 32767
# NO -scale
gdal_translate -of GTiff -co TFW=YES -a_srs EPSG:4326 -a_nodata -32767 $NC $GEOTIFF
Write-Host "✅ GEBCO GeoTIFF (WGS84) Generated"

# Generate projected Geotiff UTM33N (EPSG:32633)
$GEOTIFF_UTM = "gebco_utm33n.tif"
gdalwarp -overwrite -co TFW=YES   -s_srs EPSG:4326  -t_srs EPSG:32633 -r bilinear -dstnodata -32767 $GEOTIFF $GEOTIFF_UTM
Write-Host "✅ Geotiff Projected UTM33N Generated"

# .tfw TIFFWorld File is useful for some software to import geotiff format map
