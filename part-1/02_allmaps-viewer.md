# Lesson 3: Doing more with Allmaps

## Allmaps Viewer

[Allmaps Viewer](https://viewer.allmaps.org) is used to view georeferenced maps in Allmaps.
Similar to the *Results* tab in Editor, you can see the warped map overlaid on a web map.

Viewer also includes additional tools that let you customize the appearance and functionality of your map.

Common tools (found at the bottom of the screen) include sliders that control layer transparency/opacity and background removal.
Background removal is especially useful with historical maps—it removes the blank paper and helps isolate printed geographic content from the scanned page, making overlays easier to interpret.

Viewer is not primarily for creating georeferencing data, but for inspecting results, comparing transformations, and assessing how a warped historical map behaves in relation to modern geography.
The figure below shows a georeferenced map of New Zealand with the background removed.

<!-- TODO: Refer to this comparison the text. -->
{% include figure.html filename="georef_nz8_Background.png" alt="Comparison in Allmaps Viewer showing the same map with background removal off and on." caption="Background removal in Allmaps Viewer." %}

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

{% include figure.html filename="transform.gif" alt="Animated comparison showing how different transformation algorithms warp the same georeferenced map in different ways." caption="Different transformation algorithms can produce different warping results." %}

Once you have checked how the map behaves in the viewer, you can also use the same georeferenced map outside Allmaps.
The viewer is useful for inspecting alignment and transformation; XYZ tiles make the warped map available as a layer in desktop GIS software.

## Using XYZ Tiles in GIS

Allmaps provides a free *XYZ tile server*, allowing you to bring georeferenced maps directly into GIS software like QGIS.
Note: this is not intended for permanent hosting.

In QGIS, use the Add XYZ Layer tool:

{% include figure.html filename="QGIS1.png" alt="QGIS dialog for adding a new XYZ tile layer." caption="Opening the XYZ tile layer dialog in QGIS." %}

Copy the XYZ Tile URL from the Allmaps Editor Share tools:

{% include figure.html filename="ShareXYZ.png" alt="Allmaps export menu showing where to copy the XYZ tile URL." caption="Finding the XYZ tile URL in Allmaps." %}

Then create a new XYZ Connection in QGIS and paste in the URL. No other changes are usually needed.

{% include figure.html filename="QGIS2.png" alt="QGIS form for creating a new XYZ connection by pasting the tile URL." caption="Creating a new XYZ connection in QGIS." %}

Now you can use your georeferenced map directly in desktop GIS!

{% include figure.html filename="QGIS3.png" alt="Georeferenced historical map displayed in QGIS from the Allmaps XYZ tile service." caption="A georeferenced map displayed in QGIS." %}

<!-- TODO: Explain limitations of the Allmaps tile server, frame it as relatively short term. -->

More info on the Allmaps Tile Server is available in this [Observable notebook](https://observablehq.com/@allmaps/allmaps-tile-server).
