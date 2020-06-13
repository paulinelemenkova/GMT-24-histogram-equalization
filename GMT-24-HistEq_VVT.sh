#!/bin/bash
# Purpose:      Illustrate histogram equalization on topography grids
# Here: Vanuatu and Vityaz Trench region.
# GMT modules:  psscale, pstext, makecpt, grdhisteq, grdimage
# Unix progs:   rm
#
grdcut earth_relief_01m.grd -R145/200/-40/0 -Gvt_relief.nc
#
ps=HistEqVV.ps
gmt makecpt -Crainbow -T-11000/3000 > t.cpt
gmt makecpt -Crainbow -T0/15/1 > c.cpt
# 2
gmt grdhisteq vt_relief.nc -Gout.nc -C16
gmt grdimage vt_relief.nc -I+a45+nt1 -Ct.cpt -JM3i -Y6i -K -P -B10 -BWSne > $ps
echo "185 -5 Original" | gmt pstext -Rvt_relief.nc -J -O -K -F+jBL+f12p -T -Gwhite@10 -Dj0.1i >> $ps
gmt grdimage out.nc -Cc.cpt -J -X3.5i -K -O -B10 -BWSne >> $ps
echo "180 -5 Equalized" | gmt pstext -R -J -O -K -F+jBL+f12p -T -Gwhite@10 -Dj0.1i >> $ps
gmt psscale -Dx0i/-0.4i+jTC+w5i/0.15i+h+e+n -O -K -Ct.cpt -Ba1000 -By+lm >> $ps
# 3 low left
gmt grdhisteq vt_relief.nc -Gout.nc -N
gmt makecpt -Crainbow -T-3/3 > c.cpt
gmt grdimage out.nc -Cc.cpt -J -X-3.5i -Y-3.3i -K -O -B10 -BWSne >> $ps
echo "180 -5 Normalized" | gmt pstext -R -J -O -K -F+jBL+f12p -T \
    -UBL/-5p/-4.0c -Gwhite@10 -Dj0.1i >> $ps
# 4 low right
gmt grdhisteq vt_relief.nc -Gout.nc -Q
gmt makecpt -Crainbow -T0/15 > q.cpt
gmt grdimage out.nc -Cq.cpt -J -X3.5i -K -O -B10 -BWSne >> $ps
echo "180 -5 Quadratic" | gmt pstext -R -J -O -K -F+jBL+f12p -T -Gwhite@10 -Dj0.1i >> $ps
gmt psscale -Dx0i/-0.4i+w5i/0.15i+h+jTC+e+n -O -K -Cc.cpt -Bx1 -By+l"z@-n@-" >> $ps
gmt psscale -Dx0i/-1.0i+w5i/0.15i+h+jTC+e+n -O -K -Cq.cpt -Bx1 -By+l"z@-q@-" >> $ps
# Add GMT logo
gmt logo -Dx0.0/-4.8c+o-1.0c/0.2c+w2c -O -K >> $ps
# Add subtitle
gmt pstext -R0/10/0/15 -JX10/10 -X-8.0 -Y6.5c -N -O \
-F+f14p,Palatino-Roman,black+jLB >> $ps << EOF
0.0 13.3 Vanuatu and Vityaz trenches: Histogram equalization on topography grid:
1.5 12.5 ETOPO1 DEM Global Relief Model 1 arc min resolution
EOF
# Convert to image file using GhostScript
gmt psconvert HistEqVV.ps -A0.5c -E720 -Tj -Z
#rm -f out.nc ?.cpt
