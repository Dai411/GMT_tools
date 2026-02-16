# ================================
# Plot topography from ESRI .asc
# ================================

# ----- Region & projection -----
$R = "-R9/17/38/43"      # lon_min/lon_max/lat_min/lat_max
$J = "-JM30c"            # Mercator projection

# ----- Files -----
$ASC  = "C:\Users\yangln\Desktop\Postdoc\CNR_Italy\Maps\tirreno_all_geo_100.asc"
$GRID = "topography.grd"
$SHADE = "shade.grd"
$CPT  = "topography.cpt"

Set-Location -Path $PSScriptRoot

gmt begin EuropeTopo_ASC tif

    # 1. Convert ESRI ASCII grid to GMT grid
    gmt grdconvert $ASC $GRID

    # 2. Make color palette (sea + land)
    gmt makecpt -Chaxby "-T-3800/0/200" -Z -H | Out-File $CPT -Encoding ascii

    # 3. Compute hillshade
    gmt grdgradient $GRID "-A45" "-Ne0.6" "-G$SHADE"

    # 4. Plot grid with illumination
    gmt grdimage $GRID $R $J "-C$CPT" "-I$SHADE"

    # 5. Coastlines and map frame
    gmt coast "-W0.5p" -Df -Bxa5f1 -Bya5f1 -BWSne

    # 6. Colorbar
    gmt colorbar -Bxaf+l"Elevation (m)"

gmt end show
