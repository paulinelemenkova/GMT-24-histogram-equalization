#!/bin/bash
# Purpose: Illustrate histogram equalization on topography grids
# Here: New Zealand region, Hikurangi, Puysegur and Hjort trenches.
# GMT modules:  psscale, pstext, makecpt, grdhisteq, grdimage
# Unix progs:   rm
#
#grdcut earth_relief_01m.grd -R145/186/-62/-30 -Ghpt_relief.nc
grdcut GEBCO_2019.nc -R145/186/-62/-30 -Ghpt_relief.nc
#
ps=HistEqNZ.ps
gmt makecpt -Crainbow -T-9000/3000 > t.cpt
gmt makecpt -Crainbow -T0/15/1 > c.cpt
gmt grdhisteq hpt_relief.nc -Gout.nc -C16
# 1 upper left
gmt grdimage hpt_relief.nc -I+a45+nt1 -Ct.cpt -JM3i \
    -Y6i -K -P -Bpxg5f5a10 -Bpyg4f2a8 -Bsxg5 -Bsyg4\
    -BWSne > $ps
echo "172 -33 Original" | gmt pstext -Rhpt_relief.nc -J \
    -F+jBL+f12p -T -Gwhite@10 -Dj0.1i -O -K >> $ps
# 2 upper right
gmt grdimage out.nc -Cc.cpt -J -X3.5i \
    -Bpxg5f5a10 -Bpyg4f2a8 -Bsxg5 -Bsyg4 -BWSne -K -O >> $ps
echo "172 -33 Equalized" | gmt pstext -R -J -O -K \
    -F+jBL+f12p -T -Gwhite@10 -Dj0.1i >> $ps
gmt psscale -Dx0i/-0.4i+jTC+w5i/0.15i+h+e+n -Ct.cpt \
    -Ba1000 -By+lm -O -K >> $ps
# 3 low left
gmt grdhisteq hpt_relief.nc -Gout.nc -N
gmt makecpt -Crainbow -T-3/3 > c.cpt
gmt grdimage out.nc -Cc.cpt -J -X-3.5i -Y-4.5i\
    -Bpxg5f5a10 -Bpyg4f2a8 -Bsxg5 -Bsyg4 -BWSne -O -K >> $ps
echo "170 -33 Normalized" | gmt pstext -R -J -F+jBL+f12p -T \
    -UBL/-5p/-4.0c -Gwhite@10 -Dj0.1i -O -K >> $ps
# 4 low right
gmt grdhisteq hpt_relief.nc -Gout.nc -Q
gmt makecpt -Crainbow -T0/15 > q.cpt
gmt grdimage out.nc -Cq.cpt -J -X3.5i \
    -Bpxg5f5a10 -Bpyg4f2a8 -Bsxg5 -Bsyg4 -BWSne -O -K >> $ps
echo "170 -33 Quadratic" | gmt pstext -R -J \
    -F+jBL+f12p -T -Gwhite@10 -Dj0.1i -O -K >> $ps
gmt psscale -Dx0i/-0.4i+w5i/0.15i+h+jTC+e+n -O -K -Cc.cpt -Bx1 -By+l"z@-n@-" >> $ps
gmt psscale -Dx0i/-1.0i+w5i/0.15i+h+jTC+e+n -O -K -Cq.cpt -Bx1 -By+l"z@-q@-" >> $ps
# Add GMT logo
gmt logo -Dx0.0/-4.8c+o-1.0c/0.2c+w2c -O -K >> $ps
# Add subtitle
gmt pstext -R0/10/0/15 -JX10/10 -X-8.0 -Y13.0c -N -O \
-F+f14p,Palatino-Roman,black+jLB >> $ps << EOF
0.0 13.8 Histogram equalization on topography grid
0.0 13.0 GEBCO DEM Global Relief Model 15 arc sec resolution
0.0 12.2 New Zealand region, Hikurangi, Puysegur and Hjort trenches
EOF
# Convert to image file using GhostScript
gmt psconvert HistEqNZ.ps -A1.0c -E720 -Tj -Z
rm -f out.nc t.cpt c.cpt q.cpt
