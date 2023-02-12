#!/bin/bash
# Purpose:      Illustrate histogram equalization on topography grids
# Here: Central African Republic.
# GMT modules:  psscale, pstext, makecpt, grdhisteq, grdimage
# Unix progs:   rm
#

exec bash

gmt grdcut ETOPO1_Ice_g_gmt4.grd -R14/28/2.5/11.5 -Gcf1_relief.nc
#
ps=HistCAR.ps
gmt makecpt -Crainbow -T-11000/3000 > t.cpt
gmt makecpt -Crainbow -V -T212/1820 > t.cpt
gmt makecpt -Crainbow -T0/15/1 > c.cpt
# 1 upper left
gmt grdhisteq cf1_relief.nc -Gout.nc -C16
gmt grdimage cf1_relief.nc -I+a45+nt1 -Ct.cpt -JM3i -Y6i -K -P \
    -Bpxg4f1a2 -Bpyg4f2a2 -Bsxg2 -Bsyg2 -BWSNe > $ps
echo "24.5 10.3 Original" | gmt pstext -Rcf1_relief.nc -J -O -K -F+jBL+f12p -T -Gwhite@10 -Dj0.1i >> $ps
gmt pscoast -R -J -Ia/thinner,blue -Na -N1/thick,white -W0.1p -Df -O -K >> $ps
# 2 upper right
gmt grdimage out.nc -Cc.cpt -J -X3.5i -K -O \
    -Bpxg4f2a4 -Bpyg4f2a2 -Bsxg2 -Bsyg2 -BWSNe >> $ps
gmt pscoast -R -J -Ia/thinner,blue -Na -N1/thick,white -W0.1p -Df -O -K >> $ps
echo "24 10.3 Equalized" | gmt pstext -R -J -O -K -F+jBL+f12p -T -Gwhite@10 -Dj0.1i >> $ps
gmt psscale -Dx0i/-0.4i+jTC+w5i/0.15i+h+e+n -O -K -Ct.cpt -Bg200f10a200 -By+lm >> $ps
# 3 low left
gmt grdhisteq cf1_relief.nc -Gout.nc -N
gmt makecpt -Crainbow -T-3/3 > c.cpt
gmt grdimage out.nc -Cc.cpt -J -X-3.5i -Y-3.0i -K -O \
    -Bpxg4f2a4 -Bpyg4f2a2 -Bsxg2 -Bsyg2 -BWSNe >> $ps
gmt grdcontour cf1_relief.nc -R -J -C200 -A500+f7p,26,blue -Wthinnest,blue -O -K >> $ps
echo "23.5 10.3 Normalized" | gmt pstext -R -J -O -K -F+jBL+f12p -T \
    -UBL/-5p/-4.0c -Gwhite@10 -Dj0.1i >> $ps
gmt pscoast -R -J -Ia/thinner,blue -Na -N1/thick,white -W0.1p -Df -O -K >> $ps
# 4 low right
gmt grdhisteq cf1_relief.nc -Gout.nc -Q
gmt makecpt -Crainbow -T0/15 > q.cpt
gmt grdimage out.nc -Cq.cpt -J -X3.5i -K -O \
    -Bpxg4f2a4 -Bpyg4f2a2 -Bsxg2 -Bsyg2 -BWSNe >> $ps
gmt pscoast -R -J -Ia/thinner,blue -Na -N1/thick,white -W0.1p -Df -O -K >> $ps
echo "24 10.3 Quadratic" | gmt pstext -R -J -O -K -F+jBL+f12p -T -Gwhite@10 -Dj0.1i >> $ps
gmt psscale -Dx0i/-0.4i+w5i/0.15i+h+jTC+e+n -O -K -Cc.cpt -Bx1 -By+l"z@-n@-" >> $ps
gmt psscale -Dx0i/-1.0i+w5i/0.15i+h+jTC+e+n -O -K -Cq.cpt -Bx1 -By+l"z@-q@-" >> $ps
# Add GMT logo
gmt logo -Dx0.0/-4.7c+o-1.0c/0.2c+w2c -O -K >> $ps
# Add subtitle
gmt pstext -R0/10/0/15 -JX10/10 -X-8.0 -Y6.5c -N -O \
-F+f14p,Palatino-Roman,black+jLB >> $ps << EOF
#0.0 13.3 Central African Republic: histogram equalization of topographic grid:
0.0 11.5 Central African Republic: histogram equalization of topographic grid:
1.5 10.7 ETOPO1 DEM Global Relief Model 1 arc min resolution
EOF
# Convert to image file using GhostScript
gmt psconvert HistCAR.ps -A0.5c -E720 -Tj -Z
#rm -f out.nc ?.cpt
