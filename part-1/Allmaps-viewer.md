# Lesson 3: Doing more with Allmaps

## Allmaps Viewer

[Allmaps Viewer](https://viewer.allmaps.org) is used to view georeferenced maps in Allmaps. Similar to the **Results** tab in the Editor, you can see the map overlaid on a web map.

The Viewer also includes **additional tools** that let you customize the appearance and functionality of your map.

Common tools (found at the bottom of the screen) include sliders that control **layer transparency/opacity** and **background removal**.

Background removal is especially useful with historical maps—it removes the blank paper and helps isolate printed geographic content from the scanned page, making overlays easier to interpret.

Viewer is not primarily for creating georeferencing data, but for inspecting results, comparing transformations, and assessing how a warped historical map behaves in relation to modern geography.

{% include figure.html filename="georef_nz8_Background.png" alt="A comparison in Allmaps Viewer showing a map with and without background removal." caption="Background removal in Allmaps Viewer." %}

<div class="alert alert-warning">
Allmaps Viewer has some useful keyboard shortcuts:

- <kbd>Space</kbd> – Toggle transparency on/off
- <kbd>B</kbd> – Toggle background removal
- <kbd>M</kbd> – Display the mask
- <kbd>T</kbd> – Change the transformation algorithm
- <kbd>G</kbd> – Display a grid over the image
- <kbd>D</kbd> – Cycle display of distortions: surface deformation, angle distortion, or none
</div>

## Viewing Stitched Atlas Sheets

TODO: why stitched viewing matters methodologically

Take this example from the [Milwaukee County land use and zoning atlas](https://collections.lib.uwm.edu/digital/collection/agdm/id/36112).

TODO: Live sample may be unstable/unreliable. Consider a different example.

IIIF Manifest: `https://collections.lib.uwm.edu/iiif/info/agdm/36112/manifest.json`

Green symbols indicate sheets that are already georeferenced:

{% include figure.html filename="MultiPageGreen.png" alt="A green indicator in Allmaps Viewer marking atlas sheets that have already been georeferenced." caption="Green indicators mark georeferenced pages." %}

Yellow warning symbols indicate maps with masks but no georeferencing yet:

{% include figure.html filename="MultiPageYellow.png" alt="A yellow warning symbol in Allmaps Viewer marking maps that have masks but are not yet georeferenced." caption="Yellow indicators mark masked pages that still need georeferencing." %}

[View this atlas in Allmaps Viewer](https://viewer.allmaps.org/?url=https%3A%2F%2Fcollections.lib.uwm.edu%2Fiiif%2Finfo%2Fagdm%2F36112%2Fmanifest.json) to see how stitched maps are displayed. As more sheets are georeferenced, they’ll appear in the viewer.

{% include figure.html filename="MultiPageStitch.png" alt="Multiple georeferenced atlas sheets displayed together in Allmaps Viewer." caption="Stitched atlas sheets in Allmaps Viewer." %}

When working with multi-sheet objects:

- <kbd>[</kbd> and <kbd>]</kbd> – Cycle through maps
- <kbd>Right Click</kbd> – Change map layer order

## Changing the Transformation Algorithm

TODO: how changing algorithms affects historical interpretation, not just visual appearance.

As we covered in Lesson 2, ground control points (GCPs) define locations where features match across old and new maps. A transformation algorithm uses these points to warp the image accordingly.

Cycle through algorithms using <kbd>T</kbd>.

Different algorithms will produce different results. Some stretch or distort the image more than others—this is known as **rubber sheeting**.

{% include figure.html filename="transform.gif" alt="An animated comparison of different transformation algorithms applied to the same georeferenced map." caption="Different transformation algorithms can produce different warping results." %}


TODO: This is an abrupt transition into XYZ tiles/GIS...

## Using XYZ Tiles in GIS

Allmaps provides a free **XYZ tile server**, allowing you to bring georeferenced maps directly into GIS software like QGIS.
Note: this is not intended for permanent hosting.

In **QGIS**, use the **Add XYZ Layer** tool:

{% include figure.html filename="QGIS1.png" alt="The dialog in QGIS for adding an XYZ tile layer." caption="Opening the XYZ tile layer dialog in QGIS." %}

Copy the **XYZ Tile URL** from the Allmaps Editor Share tools:

{% include figure.html filename="ShareXYZ.png" alt="The Allmaps share menu showing where to copy the XYZ tile URL." caption="Finding the XYZ tile URL in Allmaps." %}

Then create a new XYZ Connection in QGIS and paste in the URL. No other changes are usually needed.

{% include figure.html filename="QGIS2.png" alt="The form in QGIS for creating a new XYZ connection by pasting a tile URL." caption="Creating a new XYZ connection in QGIS." %}

Now you can use your georeferenced map directly in desktop GIS!

{% include figure.html filename="QGIS3.png" alt="A georeferenced historical map loaded into QGIS from an Allmaps XYZ tile service." caption="A georeferenced map displayed in QGIS." %}

You can even use the **Export** tool to save the result as a **GeoTIFF**, a standard format for georeferenced images.

More info on the Allmaps Tile Server is available in this [Observable notebook](https://observablehq.com/@allmaps/allmaps-tile-server).
