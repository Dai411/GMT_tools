# =================================================
# Topography map from XYZ data (PowerShell + GMT 6)
# Example Reigion: Tyrrhenian Sea - UTM 33N
# Data: Network Common Data Format (NetCDF)
# =================================================

# 1. Read Data (.nc is a ready grid file)
$grd = "gebco_2024_n44.0_s37.0_w8.0_e17.0.nc"

# 2. Example Region（lon/lat）
$R = "-R8/17/37/44"

# 3. Projection（WGS84 / UTM zone 33N）
$J = "-JU33N/15c"

# 4. Calculate the maximum elevation（For symmetric colorbar）
$range = gmt grdinfo $grd $R -T
$range = $range -replace "^-T", ""

$parts = $range -split "/"
$zmin  = [double]$parts[0]
$zmax  = [double]$parts[1]
$max   = [Math]::Max([Math]::Abs($zmin), [Math]::Abs($zmax))


# 5. GMT Plot（output format is png, ps, pdf, tiff, note geotiff does not work）
gmt begin Tyrrhenian_Sea_UTM33 png

    # 6. generate Palette（Blue Sea + Green Land）
    gmt makecpt -Cgeo "-T-$($max)/$($max)/10" -Z

    # 7. Plot mophorology
    gmt grdimage $grd $R $J -C -Baf -BWSen

    # 8. Plot Caostline
    gmt coast $R $J "-W0.5p" -Df

    # 9. Colour bar（Bottom Midlle）
    gmt colorbar "-DJBC+w12c/0.5c+o0c/1c" -Bxa -By+l"Elevation / Depth (m)"

    # 10. Add Title
    "8.5 43.5 Tyrrhenian Sea (WGS84 / UTM 33N)" |
        gmt text -R -J "-F+f14p,Helvetica-Bold+jTC"

gmt end show
