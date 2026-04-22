---
layout: lesson
title: "Lesson 4: Allmaps CLI (Advanced)"
position: 4
permalink: /lessons/cli/
---

# Lesson 4: Allmaps CLI (Advanced)

In this lesson we will download a IIIF image to our local machine,
download the IIIF Georeference annotation from allmaps,
and use command line tools to generate a Cloud-Optimized GeoTIFF
to use in GIS.

> **Warning:** 
> 
> This lesson assumes some familiarity with the command line in a Unix environment
> (Linux, macOS/osX, or a Unix-like enviornment on a Windows PC),
> installing packages, and 
> generating and running scripts from the command line.
> 
> Never copy-paste code into your terminal unless you understand what it's doing.
> This lesson requires installing software like the
> [Allmaps Command Line](https://www.npmjs.com/package/@allmaps/cli),
> [Node.js](https://nodejs.org/en/download),
> [GDAL](https://gdal.org/en/stable/download.html),
> [deezoomify-rs](https://github.com/lovasoa/dezoomify-rs),
> and other dependencies.
>
> Installation and compatability with your environment will vary depending
> on your operating system, OS version, shell environment, etc. 
>
{: .callout .warning }

<a class="btn" href="#generating-a-geotiff-using-allmaps-cli">Skip setup instructions</a>
<a class="btn" href="{{ '/lessons/fun' | relative_url }}">🕹️ Have fun instead</a>

## Environment Setup

### Windows Only: Set up WSL

[Windows Subsystem for Linux Documentation](https://learn.microsoft.com/en-us/windows/wsl/)

If you don't have a Linux distribution set up for WSL, install Ubuntu:

`wsl --install -d Ubuntu`

Now you can launch a Ubuntu environment from your Windows desktop environment. Follow Linux/Unix instructions below.

### Linux/Unix
```bash
# Update and upgrade package manager
sudo apt update && sudo apt upgrade -y

# Install Node.js 20 using NodeSource
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# GDAL (geospatial library)
sudo apt install -y gdal-bin libgdal-dev
```

### macOS/OSX:

Install Homebrew if not already installed.

```bash
# Update system & Homebrew
softwareupdate -i -a
brew update && brew upgrade

# Install Node.js 20 (LTS)
brew install node@20

# GDAL (geospatial library)
brew install gdal
```

### Install Allmaps CLI and dependencies

```bash
npm install -g @allmaps/cli
```

Test it with `allmaps --help`

You need the following tools to complete the tasks performed in the leson:

[`dezoomify-rs`](https://github.com/lovasoa/dezoomify-rs)
for full image extraction;
**This requires Rust.**

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install dezoomify-rs
```

For clipboard interaction and working with IIIF or bash scripts:

```bash
sudo apt install -y xclip jq moreutils
```

> **macOS/OSX:**
>
> Install via Homebrew
>
> ```bash
> brew install dezoomify-rs
> ```
> 
> I recommend investigating other dependencies depending on your environment.
> [Homebrew](https://brew.sh/)
> works best for me on Apple silicon.
>
{: .callout .tip }


--------------------

## Generating a GeoTIFF using Allmaps CLI

This guide outlines the steps for generating a Cloud Optimized GeoTIFF (COG) of a map of Green Bay from the AGSL collection using the Allmaps CLI and GDAL.

Below under Source Information, you will find URL's for the map of Green Bay I'm using for this example. 
It's a good idea to open up a document and record URLs for the resources you're working with so it's easy to copy-paste them.

### Collect Source Information:

| **Source Information** | Description | Value / Link |
|-------------------------|-------------|--------------|
| AGSL Item Page          | Public-facing item page in the AGSL Digital Map Collection. | [https://collections.lib.uwm.edu/digital/collection/agdm/id/5922/](https://collections.lib.uwm.edu/digital/collection/agdm/id/5922/) |
| IIIF Manifest URL       | Machine-readable IIIF manifest describing the image and metadata. | [https://collections.lib.uwm.edu/iiif/info/agdm/5922/manifest.json](https://collections.lib.uwm.edu/iiif/info/agdm/5922/manifest.json) |
| Georeference Annotation | Allmaps annotation storing the georeferencing information. | [https://annotations.allmaps.org/images/82b3f8acb9a05d5b](https://annotations.allmaps.org/images/82b3f8acb9a05d5b) |
| Allmaps ID              | Unique identifier for this map in the Allmaps system. | `afbbbc974346dbbb` |
| Image ID URL            | IIIF Image API base URL for requesting tiles or derivatives. | [https://collections.lib.uwm.edu/digital/iiif/agdm/5922](https://collections.lib.uwm.edu/digital/iiif/agdm/5922) |
| Image Filename          | Original image filename on the server. | `d30944a32ca34085.jpg` |


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

> **Important:**
>
> The `mv` command, Unix for "Move", is being used here to rename the image file.
> Unless you're working with the same map I am, your filenames will be different.
> What is important is that you keep track of your filename for later steps.
> 
{: .callout .important }

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

**Make these adjustments:**

- **Remove** any `-cutline_srs` flag if present.
- **Add** `-multi -wm 2048` to the `gdalwarp` command. (Include '\')
- **Ensure** the image filename matches yours: `"82b3f8acb9a05d5b.jpg"`
- **Verify** the output filenames in `gdalwarp` and `gdalbuildvrt` are consistent, and use `\` for line continuation if the command spans multiple lines.

> **Note:**
>
> I've opened
> [an issue](https://github.com/allmaps/allmaps/issues/261)
> related to this on the Allmaps repo.
> 
{: .callout .note }

### 6. Run the Script

```bash
bash green_bay_geotiff.sh
```

Troubleshooting script failures and errors:
* See above "Download the IIIF Image" step if your image size in wrong.
* Ensure you've made the appopriate adjustments in the generated shell script in the "Edit the Script" step above.
* Triple check your filenames and ensure they match what the shell script expects.

### 7. Verify the Output with GDAL

```bash
gdalinfo d30944a32ca34085_*-warped.tif
```

**Check:**

- EPSG:3857 coordinate system
- Output dimensions and pixel size
- Geo bounding box and COG layout
