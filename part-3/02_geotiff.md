# Exporting a GeoTIFF with Allmaps CLI

In this section, you will generate a georeferenced Cloud Optimized GeoTIFF (COG) from an Allmaps annotation.

This format is commonly used for web maps and allows efficient access to large raster datasets.

For an introduction to COGs and how they enable efficient, web-based access to raster data, see [https://cogeo.org/](https://cogeo.org/).

### Confirm the Georeference Annotation

If you are working through this section with the lesson's Paris example, use the frozen annotation at `annotation.json`. If you are using a different map, use the annotation for that map instead.

### Download the IIIF Image

<!-- TODO: Add a short paragraph explaining why GeoTIFF export is fussier than the GeoJSON workflow: the generated script expects local image filenames and matching source-image dimensions. -->

```bash
allmaps fetch full-image "https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550"
ls -lh *.jpg
```

<div class="alert alert-warning">
For this example, the downloaded file should be named `adeae8a56aaf59fb.jpg`. If your file has a different name, rename it before continuing:

```bash
mv current-filename.jpg adeae8a56aaf59fb.jpg
```

</div>

By default, `allmaps fetch full-image` may not download the highest-resolution version.

To see which sizes the IIIF server can provide, inspect the image service metadata:

```bash
curl -s https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550/info.json | jq '.sizes'
```

For this example, the largest size listed should be `10784 x 6941`, matching the dimensions in the Allmaps annotation.
If your local JPEG is smaller than the largest size, it will not match the pixel coordinates in the Allmaps annotation. In that case, use `dezoomify-rs` to download the full-resolution image:

```bash
dezoomify-rs "https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550" full.jpg
mv full.jpg adeae8a56aaf59fb.jpg
```

### Generate the GeoTIFF Script

```bash
cat annotation.json | allmaps script geotiff > paris_geotiff.sh
```

This will generate a shell script file `paris_geotiff.sh` that you will run soon.

**The generated script expects a specific filename; if yours differs, it will fail.**

### Edit the Script

Open the script in VS Code or your text editor of choice:

```bash
# Visual Studio Code:
code paris_geotiff.sh

# nano
nano paris_geotiff.sh

#etc.
```

Look for this block near line 66:

```bash
gdalwarp \
  -of COG -co COMPRESS=JPEG -co QUALITY=75 \
  -dstalpha -overwrite \
  -r cubic \
  -cutline ./adeae8a56aaf59fb_2543dadd9c2fa8b1.geojson -crop_to_cutline -cutline_srs "EPSG:4326" \
  -s_srs 'EPSG:3857' \
  -t_srs 'EPSG:3857' \
  -ts 9819 6706 \
  -order 1 \
  ./adeae8a56aaf59fb_2543dadd9c2fa8b1.vrt \
  ./adeae8a56aaf59fb_2543dadd9c2fa8b1-warped.tif
```  

This command uses [`gdalwarp`](https://gdal.org/en/stable/programs/gdalwarp.html) to apply the georeferencing from the annotation and generate a georeferenced raster.

Before running the script, make the following adjustment:

**Remove** `-cutline_srs` flag. This option is not supported in all GDAL versions and may cause the script to fail.

Before: `-cutline ./adeae8a56aaf59fb_2543dadd9c2fa8b1.geojson -crop_to_cutline -cutline_srs "EPSG:4326" \`
After: `-cutline ./adeae8a56aaf59fb_2543dadd9c2fa8b1.geojson -crop_to_cutline \`

If you have sufficient available memory (RAM), you can speed up processing by adding `-multi -wm 2048`.
On low-memory systems, this may cause the command to fail.

**Add** `-multi -wm 2048` to the `gdalwarp` command.

Each line in a multi-line command must end with `\`, except the final line.
If a line is missing `\`, the command will terminate early and cause errors such as 'command not found' or 'No target filename specified'.

Your updated `gdalwarp` command block should read like this:

```bash
...
gdalwarp \
  -of COG -co COMPRESS=JPEG -co QUALITY=75 \
  -dstalpha -overwrite \
  -r cubic \
  -cutline ./adeae8a56aaf59fb_2543dadd9c2fa8b1.geojson -crop_to_cutline \
  -multi -wm 2048 \
  -s_srs 'EPSG:3857' \
  -t_srs 'EPSG:3857' \
  -ts 9819 6706 \
  -order 1 \
  ./adeae8a56aaf59fb_2543dadd9c2fa8b1.vrt \
  ./adeae8a56aaf59fb_2543dadd9c2fa8b1-warped.tif
...
```  

Save the script file:

**VS Code**: File > Save or <kbd>Ctrl+S</kbd> to save.

**nano**: <kbd>Ctrl+O</kbd> to *write out* (save), <kbd>Enter</kbd> to confirm filename, <kbd>Ctrl+X</kbd> to exit nano

**vim**: <kbd>Esc</kbd>, then type `:wq` and <kbd>Enter</kbd> to save and quit

<div class="alert alert-warning">
There is [an issue](https://github.com/allmaps/allmaps/issues/261) related to the `-cutline_srs` flag on the Allmaps repository.
</div>

### Run the Script

```bash
bash paris_geotiff.sh
```

If the script runs succesffully, the output file is now georeferenced using the control points from the Allmaps annotation.

<div class="alert alert-warning">
Troubleshooting script failures and errors:

* See above "Download the IIIF Image" step if your image size is wrong.
* Ensure you've made the appropriate adjustments in the generated shell script in the "Edit the Script" step above. Regenerate the script to start over if you mess up.
* Triple check your filenames and ensure they match what the shell script expects.
</div>

### Verify the Output with GDAL

```bash
gdalinfo *-warped.tif
```

**Check for the following in the output:**

- `EPSG:3857` — confirms the map is in Web Mercator
- `Size is ...` — shows the pixel dimensions of the output image
- `LAYOUT=COG` — confirms the file is a Cloud Optimized GeoTIFF

You do not need to understand the full output; just confirm these values appear.

You have now generated a georeferenced GeoTIFF from an Allmaps annotation. This file can be used in GIS software or served as a web-accessible raster.
