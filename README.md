# GMT Histogram Equalization — DEM Contrast Enhancement Scripts

GMT (Generic Mapping Tools) shell scripts illustrating histogram equalization and statistical transforms of topography and bathymetry grids. Using grdhisteq, each script enhances the tonal distribution of an elevation grid and compares the original data with equalized, Gaussian-normalized and quadratic-transformed versions in a multi-panel figure. The scripts have been used to generate figures in the author's cartographic and geomorphometric publications.

## What the scripts do

- extract a regional subset from a global relief grid (grdcut)
- generate colour palettes (makecpt) for the raw and transformed grids
- apply histogram equalization into a set number of divisions (grdhisteq -C)
- apply a Gaussian normalization transform (grdhisteq -N) and a quadratic transform (grdhisteq -Q)
- render the original and transformed grids side by side (grdimage) with illumination
- add colour scale bars (psscale), panel labels and annotations (pstext), GMT logo (logo)
- export to raster (psconvert) at high resolution

## Data source

Global relief: ETOPO1 DEM (1 arc-minute), via GMT earth_relief tiles.

## Files

- GMT-24-HistEq_VVT.sh: Vanuatu / Vityaz Trench region
- GMT-24-HistEq_NZ.sh: New Zealand region
- GMT-24-HistEq_CF.sh: Central African region

## Requirements

- GMT 6.x (Generic Mapping Tools): https://www.generic-mapping-tools.org
- A POSIX shell (bash)
- The relevant relief grid (ETOPO1 / earth_relief) available locally

## Usage

Place the required relief grid in the working directory, adjust the -R region at the top of the chosen script, then run:

    bash GMT-24-HistEq_VVT.sh

The script writes a PostScript file and converts it to a raster image (JPG/PNG) via psconvert.

## Author and citation

Polina Lemenkova
ORCID: https://orcid.org/0000-0002-5759-1089

These scripts accompany figures in the author's cartographic and geomorphometric papers; please cite the specific article a given figure appears in. The full publication list is available via the ORCID record above.

## License

See the LICENSE file in this repository.
