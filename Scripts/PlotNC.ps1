# ===============================
# GMT plot script (PowerShell + GMT 6)
# Example Reigion: Tyrrhenian Sea - UTM 33N
# Data:
# ===============================

# 1. 输入数据
$grd = "C:\Users\yangln\Desktop\Postdoc\CNR_Italy\Maps\GEBCO\GEBCO_17_Feb_2025\gebco_2024_n44.0_s37.0_w8.0_e17.0.nc"

# 2. 研究区域（lon/lat）
$R = "-R8/17/37/44"

# 3. 投影（WGS84 / UTM zone 33N）
$J = "-JU33N/15c"

# 4. 计算最大绝对高程（用于对称色标）
$range = gmt grdinfo $grd $R -T
$range = $range -replace "^-T", ""

$parts = $range -split "/"
$zmin  = [double]$parts[0]
$zmax  = [double]$parts[1]
$max   = [Math]::Max([Math]::Abs($zmin), [Math]::Abs($zmax))


# 5. 开始 GMT 绘图（输出 PNG，也可改成 ps/pdf）
gmt begin Tyrrhenian_Sea_UTM33 png

    # 6. 生成 CPT（蓝海 + 绿陆，类似 MATLAB）
    gmt makecpt -Cgeo "-T-$($max)/$($max)/10" -Z

    # 7. 绘制地形
    gmt grdimage $grd $R $J -C -Baf -BWSen

    # 8. 海岸线（增强地理可读性）
    gmt coast $R $J "-W0.5p" -Df

    # 9. 色标（下方居中）
    gmt colorbar "-DJBC+w12c/0.5c+o0c/1c" -Bxa -By+l"Elevation / Depth (m)"

    # 10. 标题
    "8.5 43.5 Tyrrhenian Sea (WGS84 / UTM 33N)" |
        gmt text -R -J "-F+f14p,Helvetica-Bold+jTC"

gmt end show
