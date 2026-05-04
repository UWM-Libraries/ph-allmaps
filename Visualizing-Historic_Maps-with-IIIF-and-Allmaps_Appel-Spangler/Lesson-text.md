<!-- Begin Part 1.00 -->
# Georeferencing and IIIF

## What is Georeferencing?

[Georeferencing](https://en.wikipedia.org/wiki/Georeferencing) is the process of overlaying a digital image on a map by matching pixels on the image to real geographic locations. This is commonly done with aerial and satellite photography to transform photographs into usable spatial data.

A few other Programming Hisotrian lessons have already worked with georeferencing workflows:

- [Displaying a Georeferenced Map in KnightLab's StoryMap JS](https://programminghistorian.org/en/lessons/displaying-georeferenced-map-knightlab-storymap-js)
- [Introduction to Map Warper](https://programminghistorian.org/en/lessons/introduction-map-warper)
- [Georeferencing in QGIS 2.0](https://programminghistorian.org/en/lessons/georeferencing-qgis)

Georeferencing turns scanned maps into spatial data. Once a map is aligned with geographic coordinates, it becomes possible to:
- Compare landscapes past and present, including streets, buildings, waterways, shorelines, neighborhoods, and boundaries.
- Study change over time by overlaying maps from different times.
- Join sheets from an atlas or map set into a larger view of an area.

{% include figure.html filename="Figures/georef_bok.png" alt="Historic map image aligned over a modern GIS basemap." caption="The georeferencing process places a digital image into a GIS. Source: https://gistbok-ltb.ucgis.org/page/27/concept/8131" %}

For objects with multiple sheets or pages—such as urban atlases, georeferencing can make the experience easier and more engaging.

A project by the Leventhal Map & Education Center at the Boston Public Library used Allmaps
to georeference urban atlas sheets for their [Atlascope application](https://www.atlascope.org/).

{% include figure.html filename="Figures/Atlascope.png" alt="Atlascope viewer showing georeferenced urban atlas sheets over a modern map." caption="Georeferenced atlas sheets in Atlascope." %}

Traditionally, georeferencing has been done in **GIS** (Geographic Information Systems).
Some workflows will still benefit from the power of desktop GIS applications, but the learning curve is considerable.
For more detailed background, see [*Georeferencing and Georectification*](https://gistbok-topics.ucgis.org/DC-01-030) in the GIS&T Body of Knowledge.

Thanks to modern, accessible web-mapping tools, platforms like Allmaps now make this process possible for non-experts right in a browser.

## What is IIIF?

IIIF (pronounced "triple-eye-eff"), an initialism meaning [International Image Interoperability Framework](https://iiif.io/),
is a set of open standards for delivering high-quality, attributed digital objects online at scale.
IIIF provides a consistent way for institutions to share digital images, maps, manuscripts, artworks, and even audio/visual files across different platforms.
Rather than locking media inside specific viewers or software tools, IIIF offers a standardized, flexible way to deliver these resources to any compatible application.

This means that:

- A digitized map from one library can be viewed side-by-side with one from another institution.
- A scholar can annotate or compare high-resolution images without downloading large files.
- Tools like
[Allmaps](https://allmaps.org/),
[Mirador](https://projectmirador.org/),
[Universal Viewer](https://universalviewer.io/), and
[others](https://iiif.io/get-started/vendors/)
can all read the same IIIF content.

At its core, IIIF enables interoperability—making it easier for cultural heritage institutions, educators, and developers to build user experiences around
maps, photographs, documents, and other media from all over the world.

Learn more at [iiif.io](https://iiif.io/get-started/how-iiif-works/).

<!-- TODO: Compare "old" and "new" multispectral images of the Leardo Mappamundi in a Mirador viewer. -->

Take a look at the AGSL's treasured [Leardo Mappamundi](https://collections.lib.uwm.edu/digital/collection/agdm/id/538/).
Clicking on the expand arrows allows us to view the map in full-resolution detail directly in the browser.
No need to download image files.

<iframe
  src="Assets/leardo-mirador.html"
  title="Side-by-side Mirador comparison of the original and multispectral Leardo Mappamundi"
  width="100%"
  height="650"
  allowfullscreen>
</iframe>

## Finding IIIF maps to use in Allmaps

Allmaps works best with relatively large-scale maps such as city, county, state, or country maps.
While it’s possible to georeference small-scale maps (like world maps), distortion introduced by the georeferencing process—especially in Web Mercator projection—can make them harder to work with.

Allmaps excels at georeferencing:
- Urban atlases like fire insurance atlases, plats, and quartersectional atlases
- County and state maps, highway maps, and recreation maps
- Topographic or thematic map series

<!-- TODO: Connect these source types to scholarly examples. -->

### IIIF Collections

The IIIF Consortium lists compliant collections at [this link](https://iiif.io/guides/finding_resources/).
When launching the
<!-- TODO: Confirm with Bert that this feature will be around a while. -->
[Allmaps Editor](https://editor.allmaps.org),
you'll see maps hosted by various Allmaps partners that are waiting to be georeferenced.

To georeference a specific map from a IIIF compliant collection, copy its IIIF Manifest URL located at the bottom of each item page.

The IIIF Manifest URL links to a JSON file that packages metadata information to display, annotate, and navigate the digital object.
Allmaps uses this information to fetch the image information from the hosting institution's servers.
<!-- TODO: Confirm above technical description. -->\

{% include figure.html filename="Figures/manifestURL.png" alt="UWM digital collection item page showing the IIIF Manifest URL field." caption="Finding the IIIF Manifest URL in the UWM digital collection." %}

<!-- TODO: Consider if we want to include the browser extension at all. -->

Other websites may require more sleuthing to find the manifest.
On the David Rumsey Collection, it's listed under the share menu.

{% include figure.html filename="Figures/rumsey.png" alt="David Rumsey Map Collection share menu showing IIIF manifest options." caption="Finding a IIIF manifest in the David Rumsey Map Collection." %}

If it’s not visible, tools like the [DetectIIIF browser extension](https://seige.digital/en/detektiiif/) can help.

<!-- Begin Part 1.01 -->
# Allmaps Editor

Launch the Allmaps Editor by going to [editor.allmaps.org](https://editor.allmaps.org).

You can choose a map by either:

1. Entering a IIIF Manifest URL in the text box at the top of the page
2. Scrolling down to find a map in one of the highlighted collections

 <iframe src="https://editor.allmaps.org/" title="Allmaps Editor"></iframe> 

## Masking

The first step is adding a clipping mask. This involves drawing a line around the map areas of the document to exclude the collar or marginalia. 
In other words, you're identifying the part of the scanned image that you want to georeference.
In the Allmaps lexicon, this defines a "map" on a region of the "image".

Use the Draw Mask tab to add a mask. Click to add points, and double-click to close the polygon. If you mess up, click Cancel to start over.
In the figure below, note that the pink line defines the mask and excludes the map collar from the defined map.

{% include figure.html filename="Figures/georef_nz3_Mask.png" alt="Screenshot of Allmaps Editor with a polygon clipping mask drawn around the map area." caption="Drawing a clipping mask in Allmaps Editor." %}

It's possible your image includes multiple maps! Each map gets its own mask.
In the figure below, three maps are defined from a single image:
The main map image (labeled 1) and two inset map areas (labeled 2 and 3).

{% include figure.html filename="Figures/greenpoint.jpg" alt="Scanned page showing multiple maps on one sheet, each of which would need its own mask." caption="A scanned page with multiple maps." %}

Much of the time, your mask will simply be a rectangle drawn just inside the map's neatline.

{% include figure.html filename="Figures/georef_nz4_MaskCorner.png" alt="Screenshot of a simple rectangular mask drawn just inside a map's neatline." caption="A rectangular mask drawn near the map corners." %}

## Ground Control Points

Ground Control Points (GCPs) guide Allmaps in aligning the scanned image (left side) with real-world geography (right side).

Use the Georeference tab to begin placing GCPs.
To create one, find a location that clearly matches on both sides, such as a street intersection or the corner of a recognizable building.
Click the same spot on both images.
In the figure below, note the pink dot labeled 2 on both sides of the image, in this case an easily identifiable location near Cape Reinga on the Aupōuri Peninsula of New Zealand.

{% include figure.html filename="Figures/georef_nz2_GCP.png" alt="Screenshot of Allmaps Editor with matching ground control points placed on the scanned map and the modern basemap." caption="Adding ground control points in Allmaps Editor." %}

### GCP Best Practices for Urban Atlases

- **Avoid water bodies** – they change too much over time to be reliable.
- **Use roads and buildings** – as long as they haven’t been torn down or significantly altered.
- **Check your progress** – sometimes only a few GCPs are needed. Too many can actually introduce unwanted distortion. A good check-in is after placing 5–10 points.

These guidelines are adapted from the Leventhal Map & Education Center’s guide to georeferencing with Allmaps.[^1]

Remember, landscapes change: roads shift, water levels fluctuate, buildings are raized and replaced.

### What is this doing?

Behind the scenes, placing GCPs in Allmaps creates a [*Georeference Annotation*](https://iiif.io/api/extension/georef/).
It's possible to view the georeference annotation JSON code right in Allmaps, as shown in the figure below.
The *features* object contains 



<!-- TODO: Refer to this diagram in text when introducing resource and geometry coordinates. -->
{% include figure.html filename="Figures/georef_nz2_2.png" alt="Diagram showing how pixel coordinates in the image correspond to geographic coordinates in the georeference annotation." caption="Resource coordinates and geometry coordinates in a georeference annotation." %}

Each point creates a pair of values:
- **Resource coordinates** – pixel location in the image (e.g. 3017, 4367)
- **Geometry coordinates** – geographic location in longitude/latitude (e.g. 172.936215°E, 43.7589394°S)

```json
{
  "type": "Feature",
  "properties": {
    "resourceCoords": [3017, 4367]
  },
  "geometry": {
    "type": "Point",
    "coordinates": [172.936215, 43.7589394]
  }
}
```

Allmaps uses this data to calculate the warping or stretching needed to align the image over the map.

## Results

The *Results* tab displays a preview of the map with georeferencing applied. It's a great way to check alignment and see if you're on the right track.

Notice in the figure below how the maps is displayed with it's collar removed beyond the neatline and the shape is no longer rectangular and has taken on a parallelogram shape.

{% include figure.html filename="Figures/georef_nz5_result.png" alt="Screenshot of the Results tab in Allmaps Editor showing the georeferenced preview over the basemap." caption="Previewing georeferencing results in Allmaps." %}

<!-- TODO: The interface shown here reflects Allmaps as it appeared in fall 2025, so some controls may look slightly different now. -->

In the upper right, under *Export*, you’ll see a drawer with more tools:

- Link to view in Allmaps Viewer
- Link to the annotation
- **Code** – shows the actual Georeference Annotation (JSON format).
- XYZ tile link (usable in web maps or GIS software)

On the bottom right, under *Maps* you can find:

- **Transformation** and **Projection** to modify the spatial information 
- **GCP List** – lists all your points; delete ones that don't work

<!-- TODO: Need updated screenshot. -->
{% include figure.html filename="Figures/georef_nz6_Share.png" alt="Screenshot of the Allmaps export drawer showing links to the viewer, annotation, code, and tile tools." caption="The share menu in Allmaps." %}

Click the *View in Allmaps Viewer* link in the Export menu to continue.
Next we will work with the map in Allmaps Viewer.

##### Endnotes
<!-- [^1]: Firstname Lastname, *Book Title* (Place: Publisher, Year), page number. -->
[^1]: Leventhal Map & Education Center, “Georeference Urban Atlases with Allmaps,” *Cartinal*, accessed April 22, 2026, https://cartinal.leventhalmap.org/guides/georeferencing-with-allmaps.html#best-practices-for-creating-gcps.

<!-- Begin Part 1.02 -->
# Allmaps Viewer

[Allmaps Viewer](https://viewer.allmaps.org) is used to view georeferenced maps in Allmaps.
Similar to the *Results* tab in Editor, you can see the warped map overlaid on a web map.

Viewer also includes additional tools that let you customize the appearance and functionality of your map.

Common tools (found at the bottom of the screen) include sliders that control layer transparency/opacity and background removal.
Background removal is especially useful with historical maps—it removes the blank paper and helps isolate printed geographic content from the scanned page, making overlays easier to interpret.

Viewer is not primarily for creating georeferencing data, but for inspecting results, comparing transformations, and assessing how a warped historical map behaves in relation to modern geography.
The figure below shows a georeferenced map of New Zealand with the background removed.

<!-- TODO: Refer to this comparison the text. -->
{% include figure.html filename="Figures/georef_nz8_Background.png" alt="Comparison in Allmaps Viewer showing the same map with background removal off and on." caption="Background removal in Allmaps Viewer." %}

<div class="alert alert-warning">
Allmaps Viewer has some useful keyboard shortcuts:

- <kbd>Space</kbd> – Toggle transparency on/off
- <kbd>B</kbd> – Toggle background removal
- <kbd>M</kbd> – Toggle display of the mask line
- <kbd>T</kbd> – Cycle transformation algorithm
- <kbd>G</kbd> – Display a grid over the image
- <kbd>D</kbd> – Cycle display of distortions: surface deformation, angle distortion, or none
</div>

## Viewing Stitched Atlas Sheets

<!-- TODO: Explain why stitched viewing matters methodologically. -->

Lynn, MA: https://annotations.allmaps.org/manifests/23379602e8187445

<iframe
  src="https://viewer.allmaps.org/?url=https%3A%2F%2Fannotations.allmaps.org%2Fmanifests%2F23379602e8187445"
  title="Allmaps Viewer showing georeferenced atlas sheets for Lynn, Massachusetts"
  width="100%"
  height="650"
  allowfullscreen>
</iframe>

[View in Allmaps Viewer](https://viewer.allmaps.org/?url=https%3A%2F%2Fannotations.allmaps.org%2Fmanifests%2F23379602e8187445)

Since these atlas pages were carfully masked, they mosaic almost seamlessly allowing one to explore the whole atlas at once.
Using <kbd>M</kbd> to display the mask lines shows how all the component maps fit together.

When working with multi-sheet objects:

- <kbd>[</kbd> and <kbd>]</kbd> – Cycle through maps
- <kbd>Right Click</kbd> – Change map layer order

## Changing the Transformation Algorithm

As we covered above, ground control points define locations where features match across old and new maps.
A transformation algorithm uses these points to warp the image accordingly.

Cycle through algorithms using <kbd>T</kbd>.

Different algorithms will produce different results. Some stretch or distort the image more than others.
This is known as *rubber sheeting*.

Changing the transformation algorithm can change how you interpret the map, not just how it looks.
Compare algorithms as different interpretations of the same control points, and pay attention to places where the map stretches, bends, or preserves local detail.
The animation below shows just how much changing the transofrmation algorithm can impact the overlay.

{% include figure.html filename="Figures/transform.gif" alt="Animated comparison showing how different transformation algorithms warp the same georeferenced map in different ways." caption="Different transformation algorithms can produce different warping results." %}

Once you have checked how the map behaves in the viewer, you can also use the same georeferenced map outside Allmaps.
The viewer is useful for inspecting alignment and transformation; XYZ tiles make the warped map available as a layer in desktop GIS software.

## Using XYZ Tiles in GIS

Allmaps provides a free *XYZ tile server*, allowing you to bring georeferenced maps directly into GIS software like QGIS.
Note: this is not intended for permanent hosting.

In QGIS, use the Add XYZ Layer tool:

{% include figure.html filename="Figures/QGIS1.png" alt="QGIS dialog for adding a new XYZ tile layer." caption="Opening the XYZ tile layer dialog in QGIS." %}

Copy the XYZ Tile URL from the Allmaps Editor Share tools:

{% include figure.html filename="Figures/ShareXYZ.png" alt="Allmaps export menu showing where to copy the XYZ tile URL." caption="Finding the XYZ tile URL in Allmaps." %}

Then create a new XYZ Connection in QGIS and paste in the URL. No other changes are usually needed.

{% include figure.html filename="Figures/QGIS2.png" alt="QGIS form for creating a new XYZ connection by pasting the tile URL." caption="Creating a new XYZ connection in QGIS." %}

Now you can use your georeferenced map directly in desktop GIS!

{% include figure.html filename="Figures/QGIS3.png" alt="Georeferenced historical map displayed in QGIS from the Allmaps XYZ tile service." caption="A georeferenced map displayed in QGIS." %}

<!-- TODO: Explain limitations of the Allmaps tile server, frame it as relatively short term. -->

More info on the Allmaps Tile Server is available in this [Observable notebook](https://observablehq.com/@allmaps/allmaps-tile-server).

<!-- Begin Part 3.00 -->
# Install the Allmaps CLI and dependencies

<div class="alert alert-warning">
This portion assumes some familiarity with the command line in a Unix environment
(Linux, macOS, or a Unix-like environment on a Windows PC), installing packages,
and generating and running scripts from the command line.

Never copy and paste code into your terminal unless you understand what it is doing.
This lesson requires installing software such as
[Allmaps Command Line](https://www.npmjs.com/package/@allmaps/cli),
[Node.js](https://nodejs.org/en/download),
[GDAL](https://gdal.org/en/stable/download.html),
[dezoomify-rs](https://github.com/lovasoa/dezoomify-rs),
and other dependencies.

Installation and compatibility will vary depending on your operating system,
OS version, and shell environment.
</div>

## Environment Setup

### Windows Only: Set up WSL

macOS and Linux users can skip this section and jump to [Linux and Unix](#linux-and-unix).

This lesson uses WSL for Windows because the command-line tools in this section are easiest to install and teach in a Unix-like environment.
WSL gives Windows users a Linux shell that behaves much like the macOS and Linux workflows used in the rest of the lesson, which keeps commands, paths, and troubleshooting more consistent.
Native Windows workflows are possible, but they require different setup steps.

For more detailed setup instructions, see Microsoft’s [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install) documentation.

If you don't have a Linux distribution set up for WSL, install Ubuntu via PowerShell.
Ubuntu can also be installed from the Microsoft Store after WSL is enabled, but PowerShell handles both steps in one workflow.
Open PowerShell as an administrator and install WSL:

```powershell
wsl --install
```

This installs Ubuntu by default. If WSL is already installed but Ubuntu is not, you can install Ubuntu explicitly:

```powershell
wsl --install -d Ubuntu
```

Open Ubuntu from the Windows Start menu. When the Ubuntu prompt appears, continue with the Linux and Unix instructions below.

### Linux and Unix

The commands below are written for Ubuntu and Debian-based environments, including Ubuntu on WSL, that use the `apt` package manager.
Other Linux or Unix-like systems may use different package managers, package names, and compilation methods.

Refresh the package list and apply available system updates before installing new tools:

```bash
sudo apt update
sudo apt upgrade
```

Install the current long-term support (LTS) version of Node.js using the standard installer or package manager for your operating system.

On Ubuntu, Debian, or Ubuntu on WSL, you can use the instructions from Node.js:

https://nodejs.org/en/download

Use Node.js 22 or newer, preferably the current LTS version.

After installation, confirm that Node.js and npm are available:

```bash
node --version
npm --version
```

If both commands print version numbers, continue with the next step.

Install GDAL:

```bash
sudo apt install gdal-bin libgdal-dev
```

### macOS

Install [Homebrew](https://brew.sh/) if not already installed.

Refresh Homebrew’s package list:

```zsh
brew update
```

Install Node.js. You can use the installer from Node.js or Homebrew.

```zsh
brew install node
```

After installation, confirm that Node.js and npm are available:

```bash
node --version
npm --version
```

If both commands print version numbers, continue with the next step.

Install GDAL:

```zsh
brew install gdal
```

## Install Allmaps CLI and dependencies

Install the Allmaps CLI

```bash
npm install -g @allmaps/cli
```

Confirm that Allmaps CLI and GDAL are available:

```bash
allmaps --help
gdalinfo --version
```

One example in this portion uses a small local web server to preview files in the browser.
If Python 3 is already installed, you can use its built-in server.
Alternatively, because this lesson already uses Node.js and npm, you can use `npx http-server`.

## Tools for JSON inspection and GeoTIFF export

The GeoJSON workflow uses jq to inspect geometry types.
The GeoTIFF workflow uses jq to inspect IIIF Image API metadata and dezoomify-rs to download a full-resolution image when the source image dimensions do not match the Allmaps annotation.

On Ubuntu/Debian or Ubuntu on WSL, install jq:

```bash
sudo apt install jq
```

On macOS, install jq with Homebrew:

```zsh
brew install jq
```

[`dezoomify-rs`](https://github.com/lovasoa/dezoomify-rs) is used for full image extraction.

On Ubuntu/Debian or Ubuntu on WSL, install Rust and then install dezoomify-rs with Cargo:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Load Cargo in your current terminal session:

```bash
source "$HOME/.cargo/env"
```

Confirm Cargo is available:

```bash
cargo --version
```

Install dezoomify-rs:

```bash
cargo install dezoomify-rs
```

On macOS, install dezoomify-rs with Homebrew instead:

```zsh
brew install dezoomify-rs
```

Confirm the tools are available:

```bash
jq --version
dezoomify-rs --help
```

<div class="alert alert-warning">
If installation fails, the most likely missing pieces are Node.js, npm, GDAL, Rust/Cargo, or small command-line utilities such as `jq`.
After installing a new tool, you may need to restart your terminal before the command is available.
</div>

<!-- Begin Part 3.01 -->
# Draw GeoJSON on a IIIF image

The georeference metadata produced by Allmaps Editor can be used to convert geospatial coordinates to pixel coordinates to draw GeoJSON on the original unwarped map.

In the command-line examples below, `jq` is a small tool for inspecting and reshaping JSON data.

## Paris example

For the main walkthrough, this example overlays the full medieval road network from around 1300 on the 1821 AGSL map of Paris.

It is helpful to keep a record of the URLs for the resources you are working with for easy reference,
particularly if you're using an example other than the one provided.

<div class="table-wrapper" markdown="block">

| Resource | Location / URL |
| --- | --- |
| AGSL Map of Paris, 1821 | [https://collections.lib.uwm.edu/digital/collection/agdm/id/1550/](https://collections.lib.uwm.edu/digital/collection/agdm/id/1550/) |
| IIIF Manifest URL       | [https://collections.lib.uwm.edu/iiif/info/agdm/1550/manifest.json](https://collections.lib.uwm.edu/iiif/info/agdm/1550/manifest.json) |
| Viewer URL | [https://viewer.allmaps.org/?url=https%3A%2F%2Fannotations.allmaps.org%2Fimages%2Fadeae8a56aaf59fb](https://viewer.allmaps.org/?url=https%3A%2F%2Fannotations.allmaps.org%2Fimages%2Fadeae8a56aaf59fb) |
| Georeference annotation | [https://annotations.allmaps.org/images/adeae8a56aaf59fb](https://annotations.allmaps.org/images/adeae8a56aaf59fb) |
| Allmaps Image ID        | `adeae8a56aaf59fb` |
| Image ID URL            | [https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550](https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550) |
| Image Dimensions        | `10784 x 6941` |
| Original source file | Assets/voiries1300_2009.json |
| Lesson-ready file | Assets/voiries1300_2009_clean.json |
| Original ALPAGE source page | [https://alpage.huma-num.fr/ancient-urban-fabric/](https://alpage.huma-num.fr/ancient-urban-fabric/) |
| Original ALPAGE download | [https://alpage.huma-num.fr/documents/ressources/shapes/52-voieries1300_2009.zip](https://alpage.huma-num.fr/documents/ressources/shapes/52-voieries1300_2009.zip) |



</div>


### Data note

The road network was originally [published by ALPAGE](https://alpage.huma-num.fr/ancient-urban-fabric/)
as “Road network in 1300” by Caroline Bourlet and Anne-Laure Bethe.

[Download original data](https://alpage.huma-num.fr/documents/ressources/shapes/52-voieries1300_2009.zip) (optional)

The local file `Assets/voiries1300_2009.json` is derived from that source. A cleaned teaching version is included, `Assets/voiries1300_2009_clean.json`, where each `MultiLineString` has already been split into separate `LineString` features.

## Process Overview

1. Start with a historical map georeferenced with Allmaps.
2. Fetch the published georeference annotation (JSON) for that image.
3. Feed that annotation to the Allmaps CLI to build the transformation between geographic coordinates and image pixels.
4. Convert your GeoJSON from longitude/latitude into SVG coordinates measured in the original image space.
5. Display the transformed SVG as an overlay on the original, unwarped IIIF image.

Allmaps is not changing the GeoJSON into a new map projection for display in a web map. It is converting the GeoJSON into image-space coordinates so the shapes can be drawn directly on the scanned map image.

## The ingredients

For this example, we need three things:

1. A historical image that has been georeferenced in Allmaps.
   Here that is the [1821 AGSL Paris map](https://collections.lib.uwm.edu/digital/collection/agdm/id/1550/).
2. The georeference annotation for that image.
   Here that is `annotation.json`, which you will create below.
3. Some geographic data to overlay.
   Here that is `Assets/voiries1300_2009_clean.json`.

### Create a Working Directory

From the directory containing this lesson package, create a new working directory and copy the prepared GeoJSON files into it.
This keeps the downloaded and generated files isolated while you practice generating outputs from Allmaps.

```bash
mkdir -p ~/allmaps-paris
cp Assets/voiries1300_2009_clean.json ~/allmaps-paris/
cp Assets/voiries1300_2009_clean.geometries.ndjson ~/allmaps-paris/
cd ~/allmaps-paris
```

### Fetch `annotation.json` from the manifest URL

Because this IIIF manifest is already georeferenced in Allmaps, we can fetch its published annotation directly with `curl` and write it as a `.json` file:

```bash
curl -L 'https://annotations.allmaps.org/?url=https://collections.lib.uwm.edu/iiif/info/agdm/1550/manifest.json' \
  > annotation.json
```

You will see some output like this:

```bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    80  100    80    0     0     50      0  0:00:01  0:00:01 --:--:--    50
100  5771  100  5771    0     0   3284      0  0:00:01  0:00:01 --:--:--  3284
```

This works because the Allmaps annotations service can look up the published georeference annotation for a manifest URL that already exists in Allmaps.

### Confirm that the map has georeference metadata

The file `annotation.json` contains:

* the IIIF image identifier
* the image dimensions
* the ground control points
* the transformation type

You can inspect it with:

```bash
allmaps annotation parse annotation.json
```

You should see output like this:

```json
[
  {
    "@context": "https://schemas.allmaps.org/map/2/context.json",
    "type": "GeoreferencedMap",
    "id": "https://annotations.allmaps.org/maps/2543dadd9c2fa8b1",
    "created": "2026-04-03T16:46:18.241Z",
    "modified": "2026-04-03T16:46:18.241Z",
    "resource": {
      "id": "https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550",
      "width": 10784,
      "height": 6941,
      "type": "ImageService2",
      "partOf": [
...
```

That command translates the annotation into Allmaps' internal `GeoreferencedMap` format. 
This is the moment where the CLI learns how the Paris image relates to real-world coordinates.

### Inspect the prepared GeoJSON

Before transforming the GeoJSON, inspect the prepared file in two ways.
First, open [https://geojson.io](https://geojson.io) in your browser and use the open/import function to load `Assets/voiries1300_2009_clean.json`.

You should see the medieval road network drawn over the modern basemap.
This confirms that the file is valid GeoJSON with geographic longitude/latitude coordinates.

Then use `jq` to check what kinds of geometry appear in the file:

```bash
jq -r '[.features[].geometry.type] | unique[]' 'voiries1300_2009_clean.json'
```

For this dataset, the result is:

```bash
LineString
```

This matters because the next steps assume each feature can be transformed and drawn as a line, rather than as mixed geometry types that would need extra cleanup or styling.

To keep this lesson focused, the GeoJSON cleanup has already been done. The lesson package includes both the cleaned `FeatureCollection` and a prepared geometry stream for the CLI:

* `Assets/voiries1300_2009_clean.json`
* `Assets/voiries1300_2009_clean.geometries.ndjson`

The second file contains one geometry per line, ready to be piped into the local Allmaps CLI.
`.ndjson` is a Newline Delimited JSON file.

### Transform GeoJSON into image-space SVG

Now we can run the actual Allmaps transformation:

```bash
allmaps transform geojson \
  -a annotation.json \
  < voiries1300_2009_clean.geometries.ndjson \
  > voiries1300_2009.svg
```

If this runs without error, expect not to see anything output to your shell.

This command is worth unpacking carefully:

* `transform geojson` takes geographic geometry and converts it into resource coordinates
* `-a annotation.json` supplies the georeference annotation
* `< voiries1300_2009_clean.geometries.ndjson` sends the prepared geometries into the command through standard input
* `> voiries1300_2009.svg` saves the transformed output as SVG
* `\` is a line continuation character. It tells the shell to treat the next line as part of the same command.

The result is not new GeoJSON. It is an SVG graphic whose coordinates match the pixel grid of the 1821 Paris image.

### Overlay the SVG on the IIIF image

Once `voiries1300_2009.svg` exists, the hard part is done. You now have:

* the historical image served via IIIF
* an SVG whose coordinates line up with that image

For a quick visual check, make a small web page.
The page creates an SVG with the IIIF image first, then adds the transformed road lines on top.

From `annotation.json`, we know the original image dimensions:

```json
    "resource": {
      "id": "https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550",
      "width": 10784,
      "height": 6941,
      ...
```

Create a file named `paris-road-overlay.html` (in the same directory as `voiries1300_2009.svg`) that contains the content below:

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Paris road overlay</title>
    <style>
      body {
        margin: 0;
      }

      svg {
        display: block;
        width: 100vw;
        height: auto;
      }
    </style>
  </head>
  <body>
    <div id="map"></div>

    <script>
      const width = 10784
      const height = 6941
      const imageUrl =
        'https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550/full/full/0/default.jpg'

      // Use fetch() to request the file voiries1300_2009.svg
      async function main() {
        const transformedSvg = await fetch('voiries1300_2009.svg').then(
          (response) => response.text()
        )

        // Take the SVG generated by Allmaps, remove its outer wrapper
        const roadLines = transformedSvg
          .replace('<svg xmlns="http://www.w3.org/2000/svg">', '')
          .replace('</svg>', '')
          // Style the road lines in cyan for high contrast
          .replaceAll(
            '<polyline ',
            '<polyline style="stroke: #00ffff; fill: none; stroke-width: 10; stroke-linecap: round; stroke-linejoin: round;" '
          )

        // Find the empty map container, fill it with one SVG containing the Paris map image plus the transformed road overlay.
        document.querySelector('#map').innerHTML = `
          <svg viewBox="0 0 ${width} ${height}" width="${width}" height="${height}">
            <image href="${imageUrl}" width="${width}" height="${height}" />
            ${roadLines}
          </svg>
        `
      }

      main()
    </script>
  </body>
</html>
```

This HTML page loads the original IIIF image, reads the SVG created by Allmaps, styles the road lines, and draws both layers together in the same pixel coordinate space.

Because the page uses `fetch()` to load `voiries1300_2009.svg`, open it through a small local web server.

If Python 3 is installed, use its built-in server:

```bash
python3 -m http.server 8000
```
Alternatively, use Node/npm:

```bash
npx http-server . -p 8000
```

Then open `http://localhost:8000/paris-road-overlay.html` in your browser.
You should see the 1821 Paris map with the medieval road network drawn over it in bright cyan.

Allmaps gives us a transformation between geographic coordinates and map image pixels.
In this example, we use that transformation to move GeoJSON into the image's own coordinate space, then draw the resulting SVG on top of the original IIIF image.

<!-- Begin Part 3.02 -->
# Exporting a GeoTIFF with Allmaps CLI

In this section, you will generate a georeferenced Cloud Optimized GeoTIFF (COG) from an Allmaps annotation.
This format is commonly used for web maps and allows efficient access to large raster datasets.

For an introduction to COGs and how they enable efficient, web-based access to raster data, see [https://cogeo.org/](https://cogeo.org/).

<!-- TODO: this annotation should be the same as the one we downloaded in the geojson portion. Overwrite? -->
### Download the Georeference Annotation

First, ensure we're in our working directory.

```bash
cd ~/allmaps-paris
```

```bash
curl -L "https://annotations.allmaps.org/images/adeae8a56aaf59fb" -o annotation.json
```

Swap out `adeae8a56aaf59fb` for whatever Allmaps image you're working with.

### Download the IIIF Image

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
