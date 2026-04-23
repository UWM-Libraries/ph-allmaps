# Exporting a GeoTIFF with Allmaps CLI

This guide outlines the steps for generating a Cloud Optimized GeoTIFF (COG) of a map of Green Bay from the AGSL collection using the Allmaps CLI and GDAL.

Below under Source Information, you will find URLs for the map of Green Bay I'm using for this example.
It's a good idea to open up a document and record URLs for the resources you're working with so it's easy to copy-paste them.

### Collect Source Information

<div class="table-wrapper" markdown="block">

| **Source Information** | Description | Value / Link |
|-------------------------|-------------|--------------|
| AGSL Item Page          | Public-facing item page in the AGSL Digital Map Collection. | [https://collections.lib.uwm.edu/digital/collection/agdm/id/5922/](https://collections.lib.uwm.edu/digital/collection/agdm/id/5922/) |
| IIIF Manifest URL       | Machine-readable IIIF manifest describing the image and metadata. | [https://collections.lib.uwm.edu/iiif/info/agdm/5922/manifest.json](https://collections.lib.uwm.edu/iiif/info/agdm/5922/manifest.json) |
| Georeference Annotation | Allmaps annotation storing the georeferencing information. | [https://annotations.allmaps.org/images/82b3f8acb9a05d5b](https://annotations.allmaps.org/images/82b3f8acb9a05d5b) |
| Allmaps ID              | Unique identifier for this map in the Allmaps system. | `afbbbc974346dbbb` |
| Image ID URL            | IIIF Image API base URL for requesting tiles or derivatives. | [https://collections.lib.uwm.edu/digital/iiif/agdm/5922](https://collections.lib.uwm.edu/digital/iiif/agdm/5922) |
| Image Filename          | Original image filename on the server. | `d30944a32ca34085.jpg` |

</div>


### 1. Create a Working Directory

Create a new directory for your image to keep it isolated from other images as you practice generating GeoTIFFs from Allmaps.

```bash
mkdir -p ~/allmaps/agsl-green-bay
cd ~/allmaps/agsl-green-bay
```

### 2. Download the Georeference Annotation

```bash
curl -L "https://annotations.allmaps.org/images/82b3f8acb9a05d5b" -o annotation.json
```

Swap out `82b3f8acb9a05d5b` for whatever Allmaps image you're trying to work with.

### 3. Download the IIIF Image

```bash
allmaps fetch full-image "https://collections.lib.uwm.edu/digital/iiif/agdm/5922"
mv *.jpg 82b3f8acb9a05d5b.jpg
```

<div class="alert alert-warning">
The `mv` command is being used here to rename the image file. Unless you're working with the same map used in this example, your filenames will be different. Keep track of your filename for later steps.
</div>

By default, `allmaps fetch full-image` may not download the highest-resolution version.

To check if you downloaded the correct size:

```bash
curl -s https://collections.lib.uwm.edu/digital/iiif/agdm/5922/info.json | jq '.sizes'
```

If the image dimensions listed in the Allmaps annotation don't match your downloaded image, use `dezoomify-rs`:

```bash
dezoomify-rs "https://collections.lib.uwm.edu/digital/iiif/agdm/5922" full.jpg
mv full.jpg 82b3f8acb9a05d5b.jpg
```

### 4. Generate the GeoTIFF Script

```bash
cat annotation.json | allmaps script geotiff > green_bay_geotiff.sh
```

This will generate a shell script file `green_bay_geotiff.sh` that you will run soon.

If you inspect the contents of the file,
you will see that the image name is hardcoded into the
GDAL commands used in the script.
This is why it's crucially important to know what you named your
image file and that it matches the
expected name in the annotation.

### 5. Edit the Script

Open the script in VS Code or your editor of choice:

```bash
# Visual Studio Code:
code green_bay_geotiff.sh

# nano
nano green_bay_geotiff.sh

#etc.
```

Make these adjustments:

- **Remove** any `-cutline_srs` flag if present.
- **Add** `-multi -wm 2048` to the `gdalwarp` command. (Include '\')
- **Ensure** the image filename matches yours: `"82b3f8acb9a05d5b.jpg"`
- **Verify** the output filenames in `gdalwarp` and `gdalbuildvrt` are consistent, and use `\` for line continuation if the command spans multiple lines.

<div class="alert alert-warning">
I've opened [an issue](https://github.com/allmaps/allmaps/issues/261) related to this on the Allmaps repository.
</div>

### 6. Run the Script

```bash
bash green_bay_geotiff.sh
```

Troubleshooting script failures and errors:

* See above "Download the IIIF Image" step if your image size in wrong.
* Ensure you've made the appropriate adjustments in the generated shell script in the "Edit the Script" step above.
* Triple check your filenames and ensure they match what the shell script expects.

### 7. Verify the Output with GDAL

```bash
gdalinfo d30944a32ca34085_*-warped.tif
```

**Check:**

- EPSG:3857 coordinate system
- Output dimensions and pixel size
- Geo bounding box and COG layout
