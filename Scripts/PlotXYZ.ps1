# ============================================================
# Topography map from XYZ data (PowerShell + GMT 6)
# Example Region: 3–25 E, 30–55 N (Europe / Mediterranean)
# Data: lon lat elevation (meters)
# ============================================================

# ------------------------------
# Basic parameters
# ------------------------------

$R    = "-R3/25/30/55"          # Map region: lon_min/lon_max/lat_min/lat_max
$J    = "-JM15c"                # Mercator projection, map width 15 cm
$I    = "-I0.05"                # Grid spacing: 0.05° (~5 km)
$DATA = "Europe_Topography.xyz"
$GRID = "topography.grd"        # Output grid file
$CPT  = "topography.cpt"        # Color palette table

# Move to script directory (important for output files)
Set-Location -Path $PSScriptRoot


# ==============================
# Start GMT modern mode session
# ==============================

gmt begin Europe_Topography png

    # --------------------------------------------------
    # 1. Create CPT (topography color scale)
    # --------------------------------------------------
    # -Cgeo              : standard topography/bathymetry colormap
    # -T-5000/5000/500   : elevation range (adjust if needed)
    # -H                 : force output to stdout (required in modern mode)
    #
    # Out-File:
    # -Encoding ascii is REQUIRED (GMT cannot read UTF-16)
    gmt makecpt -Cgeo "-T-5000/5000/500" -H | Out-File $CPT -Encoding ascii


    # --------------------------------------------------
    # 2. Blockmean (reduce data clustering)
    # --------------------------------------------------
    # This step is essential for stable surface interpolation
    gmt blockmean $DATA $R $I > topo_mean.xyz


    # --------------------------------------------------
    # 3. Surface interpolation (XYZ → grid)
    # --------------------------------------------------
    # -G$GRID : output grid file
    # -T0.25  : tension factor (0.2–0.35 recommended for topography)
    gmt surface topo_mean.xyz $R $I "-G$GRID" "-T0.25"


    # --------------------------------------------------
    # 4. Create hillshade (optional but recommended)
    # --------------------------------------------------
    # -A45    : illumination azimuth
    # -Ne0.6  : normalized gradient (controls contrast)
    gmt grdgradient $GRID -A45 "-Ne0.6" "-Gshade.grd"


    # --------------------------------------------------
    # 5. Plot topography
    # --------------------------------------------------
    # -C$CPT        : apply color palette
    # -Ishade.grd  : add hillshade for relief
    gmt grdimage $GRID $R $J "-C$CPT" "-Ishade.grd"


    # --------------------------------------------------
    # 6. Coastlines and map frame
    # --------------------------------------------------
    # -Df           : full-resolution coastline
    # -W0.5p        : coastline pen
    # -Bxa5f1       : longitude annotations
    # -Bya5f1       : latitude annotations
    # -BWSne        : draw map frame
    gmt coast -Df "-W0.5p,black" -Bxa5f1 -Bya5f1 -BWSne+t"Topography from XYZ data"


    # --------------------------------------------------
    # 7. Colorbar
    # --------------------------------------------------
    # -DjMR         : place at Middle Right
    # +w6c/0.4c     : width / height
    # -Bxaf         : automatic annotations
    gmt colorbar "-DjMR+w6c/0.4c+o1c/0c" "-C$CPT" -Bxaf+l"Elevation (m)"

gmt end show


# --------------------------------------------------
# 8. Clean up temporary files
# --------------------------------------------------
if (Test-Path topo_mean.xyz) { Remove-Item topo_mean.xyz }
if (Test-Path shade.grd)     { Remove-Item shade.grd }
