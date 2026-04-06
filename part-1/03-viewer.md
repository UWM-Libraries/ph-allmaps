---
layout: lesson
title: "Lesson 3: Viewing and Using Maps Georeferenced in Allmaps"
position: 3
permalink: /lessons/viewer/
---

# Lesson 3: Doing more with Allmaps

## Allmaps Viewer

[Allmaps Viewer](https://viewer.allmaps.org) is used to view georeferenced maps in Allmaps. Similar to the **Results** tab in the Editor, you can see the map overlaid on a web map.
The Viewer also includes **additional tools** that let you customize the appearance and functionality of your map.

Common tools (found at the bottom of the screen) include sliders that control **layer transparency/opacity** and **background removal**.

Background removal is especially useful with historical maps—it removes the blank paper and allows the cartographic information to shine.

![Background removal comparison in Allmaps Viewer]({{ '/assets/images/georef_nz8_Background.png' | relative_url }})

Keyboard shortcuts:

- <kbd>Space</kbd> – Toggle transparency on/off
- <kbd>B</kbd> – Toggle background removal
- <kbd>M</kbd> – Display the mask
- <kbd>T</kbd> – Change the transformation algorithm
- <kbd>G</kbd> – Display a grid over the image
- <kbd>D</kbd> – Cycle display of distortions: surface deformation, angle distortion, or none

## Viewing Stitched Atlas Sheets

Take this example from the [Milwaukee County land use and zoning atlas](https://collections.lib.uwm.edu/digital/collection/agdm/id/36112).

IIIF Manifest: `https://collections.lib.uwm.edu/iiif/info/agdm/36112/manifest.json`

Green symbols indicate sheets that are already georeferenced:

![Green indicator for georeferenced pages]({{ '/assets/images/MultiPageGreen.png' | relative_url }})

Yellow warning symbols indicate maps with masks but no georeferencing yet:

![Yellow warning symbol for masked-only pages]({{ '/assets/images/MultiPageYellow.png' | relative_url }})

[View this atlas in Allmaps Viewer](https://viewer.allmaps.org/?url=https%3A%2F%2Fcollections.lib.uwm.edu%2Fiiif%2Finfo%2Fagdm%2F36112%2Fmanifest.json) to see how stitched maps are displayed. As more sheets are georeferenced, they’ll appear in the viewer.

![Example of stitched atlas sheets in Allmaps Viewer]({{ '/assets/images/MultiPageStitch.png' | relative_url }})

When working with multi-sheet objects:

- <kbd>[</kbd> and <kbd>]</kbd> – Cycle through maps
- <kbd>Right Click</kbd> – Change map layer order

## Changing the Transformation Algorithm

As we covered in Lesson 2, ground control points (GCPs) define locations where features match across old and new maps. A transformation algorithm uses these points to warp the image accordingly.

Cycle through algorithms using <kbd>T</kbd>.

Different algorithms will produce different results. Some stretch or distort the image more than others—this is known as **rubber sheeting**.

![Comparison of different transformation algorithms]({{ '/assets/images/transform.gif' | relative_url }})

## Using XYZ Tiles in GIS

Allmaps provides a free **XYZ tile server**, allowing you to bring georeferenced maps directly into GIS software like QGIS.
Note: this is not intended for permanent hosting.

In **QGIS**, use the **Add XYZ Layer** tool:

![Opening XYZ tile layer dialog in QGIS]({{ '/assets/images/QGIS1.png' | relative_url }})

Copy the **XYZ Tile URL** from the Allmaps Editor Share tools:

![Where to find the tile URL]({{ '/assets/images/ShareXYZ.png' | relative_url }})

Then create a new XYZ Connection in QGIS and paste in the URL. No other changes are usually needed.

![Adding a new XYZ connection in QGIS]({{ '/assets/images/QGIS2.png' | relative_url }})

Now you can use your georeferenced map directly in desktop GIS!

![Georeferenced map shown inside QGIS]({{ '/assets/images/QGIS3.png' | relative_url }})

You can even use the **Export** tool to save the result as a **GeoTIFF**, a standard format for georeferenced images.

More info on the Allmaps Tile Server is available in this [Observable notebook](https://observablehq.com/@allmaps/allmaps-tile-server).

## More You Can Do

What will *you* do with your georeferenced maps?

Here are just a few exciting examples:

- [Stories from Urban Atlases of Waltham](https://www.leventhalmap.org/articles/waltham-urban-atlas-essays/)
- [Atlascope](https://www.atlascope.org/)
- [Architectural Drawings in Allmaps](https://viewer.allmaps.org/?url=https%3A%2F%2Fsammeltassen.nl%2Fiiif-manifests%2Fallmaps%2Frivierahal-blijdorp.json)
- [Georeferenced Aerial Photographs](https://viewer.allmaps.org/?url=https%3A%2F%2Fannotations.allmaps.org%2Fimages%2F4bcc9463d2a68df4)

To go even further, explore the collection of [Allmaps Observable Notebooks](https://observablehq.com/@allmaps):

- Use IIIF maps in MapLibre, Leaflet, or OpenLayers
- Draw vector **GeoJSON** layers on top of Allmaps
- Georeference based on **toponyms** (place names)
- Learn more about the **code and architecture** of Allmaps
