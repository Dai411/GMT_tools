$env:LC_NUMERIC = "C"  # Use C locale (dot as decimal point)

$XYZ = "./../Map.xyz"
gmt convert $XYZ "-o0,1,2" -fg | gmt mapproject -Ju33N -R-180/180/-90/90 -F -C > utm33n_gmt.xyz

# Execute GMT data processing pipeline:
# 1. gmt convert: Convert and extract data
#    $XYZ: input file
#    "-o0,1,2": output columns 0, 1, 2 (typically corresponding to longitude, latitude, elevation/value)
#    -fg: force geographic coordinate format (longitude/latitude)
#
# 2. gmt mapproject: Map projection transformation
#    -Ju33N: use UTM projection, in this case, zone 33 Northern hemisphere (Italia)
#    -R-180/180/-90/90: set region range (longitude west 180 to east 180, latitude south 90 to north 90)
#    -F: output geographic and projected coordinates
#    -C: output projection conversion information
#
# 3. > utm33n_gmt.xyz: redirect results to output file
