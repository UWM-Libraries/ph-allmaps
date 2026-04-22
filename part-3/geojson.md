# Draw GeoJSON on a IIIF image

The georeference metadata produced by Allmaps Editor can be used to convert geospatial coordinates to pixel coordinates to draw GeoJSON on the original unwarped map.

In the command-line examples below, `jq` is a small tool for inspecting and reshaping JSON data.

## Paris example

For the main walkthrough, this example overlays the full medieval road network from around 1300 on the 1821 AGSL map of Paris.

<div class="table-wrapper" markdown="block">

| Resource | Location / URL |
| --- | --- |
| AGSL Map of Paris, 1821 | `https://collections.lib.uwm.edu/digital/collection/agdm/id/1550/` |
| Original source file | `part-3/voiries1300_2009.json` |
| Lesson-ready file | `part-3/voiries1300_2009_clean.json` |
| Original ALPAGE source page | `https://alpage.huma-num.fr/ancient-urban-fabric/` |
| Original ALPAGE download | `https://alpage.huma-num.fr/documents/ressources/shapes/52-voieries1300_2009.zip` |
| Stanford redistribution record | `https://geodiscovery.uwm.edu/catalog/stanford-vt213bp3546` |
| Viewer URL | `https://viewer.allmaps.org/?url=https%3A%2F%2Fannotations.allmaps.org%2Fimages%2Fadeae8a56aaf59fb` |
| Georef annotation | `https://annotations.allmaps.org/images/adeae8a56aaf59fb` |

</div>

### Data note

The road network was originally published by ALPAGE as “Road network in 1300” by Caroline Bourlet and Anne-Laure Bethe. The Stanford/Geodiscovery record linked above is a later redistribution of that ALPAGE dataset. The local file `part-3/voiries1300_2009.json` is derived from that source, and for this lesson I also saved a cleaned teaching version, `part-3/voiries1300_2009_clean.json`, where each `MultiLineString` has already been split into separate `LineString` features.

## Process Overview

1. Start with a georeferenced historical image.
2. Fetch the published georeference annotation for that image.
3. Feed that annotation to the Allmaps CLI so it can build a transformation between geographic coordinates and image pixels.
4. Convert your GeoJSON from longitude/latitude into SVG coordinates measured in the original image space.
5. Draw that SVG on top of the unwarped IIIF image.

Allmaps is not changing the GeoJSON into a new map projection for display in Leaflet. It is converting the GeoJSON into image-space coordinates so the shapes can be drawn directly on the scanned map image.

### The ingredients

For this example, we need three things:

1. A historical image that has been georeferenced in Allmaps.
   Here that is the 1821 AGSL Paris map.
2. The georeference annotation for that image.
   Here that is `part-3/annotation.json`.
3. Some geographic data to overlay.
   Here that is `part-3/voiries1300_2009_clean.json`.

### Step 1: Fetch `annotation.json` from the manifest URL

Because this IIIF manifest is already georeferenced in Allmaps, we can fetch its published annotation directly with `curl`:

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

### Step 2: Confirm that the map has georeference metadata

The local file `part-3/annotation.json` is a Georeference Annotation exported from Allmaps. It contains:

* the IIIF image identifier
* the image dimensions
* the ground control points
* the transformation type

You can inspect it with:

```bash
npx allmaps annotation parse annotation.json
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
Conceptually, this is the moment where the CLI learns how the Paris image relates to real-world coordinates.

### Step 3: Look closely at the GeoJSON you want to draw

Start by checking what kinds of geometry appear in the file:

```bash
jq -r '[.features[].geometry.type] | unique[]' 'voiries1300_2009_clean.json'
```

For this dataset, the result is:

```bash
LineString
```

### Step 4: Use the prepared CLI input

To keep this lesson in scope, the GeoJSON cleanup has already been done. Alongside the cleaned `FeatureCollection`, this directory includes a prepared geometry stream for the CLI:

* `part-3/voiries1300_2009_clean.json`
* `part-3/voiries1300_2009_clean.geometries.ndjson`

The second file contains one geometry per line, ready to be piped into the local Allmaps CLI.

### Step 5: Transform GeoJSON into image-space SVG

Now we can run the actual Allmaps transformation:

```bash
npx allmaps transform geojson \
  -a annotation.json \
  < voiries1300_2009_clean.geometries.ndjson \
  > voiries1300_2009.svg
```

If this runs without error, expect not to see anything output to your shell.

This command is worth unpacking:

* `transform geojson` take geographic geometry and convert it into resource coordinates
* `-a annotation.json` supplies the georeference annotation
* `< voiries1300_2009_clean.geometries.ndjson` sends the prepared geometries into the command through standard input
* `> voiries1300_2009.svg` saves the transformed output as SVG
* `\` is a line contiuation character, this simply tells our shell to treat the next line as part of the same command.

The result is not new GeoJSON. It is an SVG graphic whose coordinates match the pixel grid of the 1821 Paris image.

### Step 6: Overlay the SVG on the IIIF image

Once `voiries1300_2009.svg` exists, the hard part is done. You now have:

* the historical image served via IIIF
* an SVG whose coordinates line up with that image

#### 5a. Use the historical image as the base layer

The AGSL Paris map is available as a IIIF image service. The full image URL is:

```text
https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550/full/full/0/default.jpg
```

From `annotation.json`, we already know the image dimensions:

```json
    "resource": {
      "id": "https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550",
      "width": 10784,
      "height": 6941,
      ...
```

Those dimensions become the shared extent for both the map image and the overlay.

#### 5b. Use a pixel-space projection in OpenLayers

For this kind of overlay, we are not building a Web Mercator map.
We are building an image viewer.
So the OpenLayers projection can simply use image pixels as its units.

That means the extent is:

```js
const extent = [0, 0, 10784, 6941]
```

#### 5c. Load the SVG as a second image layer

The file `voiries1300_2009.svg` contains the transformed street segments. 
Because its coordinates already match the map image,
OpenLayers can draw it on top of the base image as long as both layers use the same extent.

One practical detail is that the generated SVG does not include a `viewBox`, `width`, or `height`,
so the example page adds those before passing the SVG to OpenLayers.

Here are the most important blocks from `openlayers-overlay.html`:

First, the page defines a pixel-based projection using the image dimensions:

```js
const width = 10784
const height = 6941
const extent = [0, 0, width, height]

const projection = new ol.proj.Projection({
  code: 'paris-image-pixels',
  units: 'pixels',
  extent
})
```

Next, it fetches the transformed SVG and injects the missing `width`, `height`, and `viewBox` attributes so OpenLayers can treat it as an image layer:

```js
async function createOverlayUrl() {
  const svgText = await fetch('./voiries1300_2009.svg').then(
    (response) => response.text()
  )

  const styledSvg = svgText.replace(
    '<svg xmlns="http://www.w3.org/2000/svg">',
    `<svg xmlns="http://www.w3.org/2000/svg" width="${width}" height="${height}" viewBox="0 0 ${width} ${height}">`
  )

  return URL.createObjectURL(
    new Blob([styledSvg], { type: 'image/svg+xml' })
  )
}
```

Finally, it creates two `ImageStatic` layers with the same extent: one for the IIIF base image and one for the SVG overlay:

```js
new ol.Map({
  target: 'map',
  layers: [
    new ol.layer.Image({
      source: new ol.source.ImageStatic({
        url: iiifImageUrl,
        imageExtent: extent,
        projection
      })
    }),
    new ol.layer.Image({
      source: new ol.source.ImageStatic({
        url: overlayUrl,
        imageExtent: extent,
        projection
      })
    })
  ],
  view: new ol.View({
    projection,
    center: ol.extent.getCenter(extent),
    zoom: 4
  })
})
```

#### 5d. Run the example

This directory now includes a minimal example page. Serve the current directory with either Python or Node.js:

```bash
python3 -m http.server 8000
```

or

```bash
npx http-server . -p 8000
```

Then open `http://localhost:8000/openlayers-overlay.html` in your browser.

#### What the OpenLayers example is doing

The example page does four important things:

1. creates a custom OpenLayers projection whose units are image pixels
2. loads the IIIF map image as an `ImageStatic` layer
3. loads the transformed SVG as another `ImageStatic` layer
4. assigns both layers the same extent, so they line up


### Takeaway

1. Allmaps gives us a transformation between map image pixels and geographic coordinates.
2. We use that transformation backwards to move GeoJSON into the image's own coordinate space.
3. The output becomes SVG because SVG is a natural format for drawing vector shapes over an image.
