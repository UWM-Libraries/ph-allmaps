# Draw GeoJSON on a IIIF image

The georeference metadata produced by Allmaps Editor can be used to convert geospatial coordinates to pixel coordinates to draw GeoJSON on the original unwarped map.

In the command-line examples below, `jq` is a small tool for inspecting and reshaping JSON data.

## Paris example

For the main walkthrough, this example overlays the full medieval road network from around 1300 on the 1821 AGSL map of Paris.

It is helpful to keep a record of the URLs for the resources you are working with for easy reference, particularly if you're using an example other than the one provided.

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
| Original source file | voiries1300_2009.json |
| Lesson-ready file | voiries1300_2009_clean.json |
| Original ALPAGE source page | [https://alpage.huma-num.fr/ancient-urban-fabric/](https://alpage.huma-num.fr/ancient-urban-fabric/) |
| Original ALPAGE download | [https://alpage.huma-num.fr/documents/ressources/shapes/52-voieries1300_2009.zip](https://alpage.huma-num.fr/documents/ressources/shapes/52-voieries1300_2009.zip) |

</div>

### Data note

The road network was originally [published by ALPAGE](https://alpage.huma-num.fr/ancient-urban-fabric/) as "Road network in 1300" by Caroline Bourlet and Anne-Laure Bethe.

[Download original data](https://alpage.huma-num.fr/documents/ressources/shapes/52-voieries1300_2009.zip) (optional)

The local file `voiries1300_2009.json` is derived from that source. A cleaned teaching version is included, `voiries1300_2009_clean.json`, where each `MultiLineString` has already been split into separate `LineString` features.

## Process Overview

1. Start with a historical map georeferenced with Allmaps.
2. Copy the frozen georeference annotation (JSON) for that image.
3. Feed that annotation to the Allmaps CLI to build the transformation between geographic coordinates and image pixels.
4. Convert your GeoJSON from longitude/latitude into SVG coordinates measured in the original image space.
5. Display the transformed SVG as an overlay on the original, unwarped IIIF image.

Allmaps is not changing the GeoJSON into a new map projection for display in a web map. It is converting the GeoJSON into image-space coordinates so the shapes can be drawn directly on the scanned map image.

## The ingredients

For this example, we need three things:

1. A historical image that has been georeferenced in Allmaps.
   Here that is the [1821 AGSL Paris map](https://collections.lib.uwm.edu/digital/collection/agdm/id/1550/).
2. The georeference annotation for that image.
   Here that is `annotation.json`, a frozen copy included with this directory.
3. Some geographic data to overlay.
   Here that is `voiries1300_2009_clean.json`.

### Start from the lesson directory

Run these commands from the directory containing this lesson file. The prepared annotation and GeoJSON files are already included here.

```bash
ls annotation.json
ls voiries1300_2009_clean.json
ls voiries1300_2009_clean.geometries.ndjson
```

### Use the frozen `annotation.json`

Because Allmaps georeferencing data can be edited, this lesson uses a frozen copy of the Paris georeference annotation included at `annotation.json`.

That local copy was downloaded from the Allmaps annotations service using the Paris map's IIIF manifest URL:

[https://annotations.allmaps.org/?url=https://collections.lib.uwm.edu/iiif/info/agdm/1550/manifest.json](https://annotations.allmaps.org/?url=https://collections.lib.uwm.edu/iiif/info/agdm/1550/manifest.json)

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
First, open [https://geojson.io](https://geojson.io) in your browser and use the open/import function to load `voiries1300_2009_clean.json`.

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

To keep this lesson focused, the GeoJSON cleanup has already been done. This directory includes both the cleaned `FeatureCollection` and a prepared geometry stream for the CLI:

* `voiries1300_2009_clean.json`
* `voiries1300_2009_clean.geometries.ndjson`

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
