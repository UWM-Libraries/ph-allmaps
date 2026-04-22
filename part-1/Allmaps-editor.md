
## Allmaps Editor

If you haven't already, launch the Allmaps Editor by going to [editor.allmaps.org](https://editor.allmaps.org).

You can choose a map by either:

1. Entering a **IIIF Manifest URL** in the text box at the top of the page
2. Scrolling down to find a map in one of the highlighted collections

 <iframe src="https://editor.allmaps.org/" title="Allmaps Editor"></iframe> 

## Masking

The first step is adding a **clipping mask**. This involves drawing a line around the map areas of the document to exclude the collar or marginalia. 
In other words, you're identifying the part of the scanned image that you want to georeference.

Use the **Draw Mask** tab to add a mask. Click to add points, and double-click to close the polygon. If you mess up, click **Cancel** to start over.

{% include figure.html filename="georef_nz3_Mask.png" alt="Allmaps Editor showing a polygon mask drawn around the map area." caption="Drawing a clipping mask in Allmaps Editor." %}

It's possible your image includes multiple maps! Each map gets its own mask.

{% include figure.html filename="greenpoint.jpg" alt="A scanned page containing multiple mapped areas that would need separate masks." caption="A scanned page with multiple maps." %}

Much of the time, your mask will simply be a rectangle drawn just inside the map's neatline.

{% include figure.html filename="georef_nz4_MaskCorner.png" alt="A rectangular mask drawn near the corners of a map inside its neatline." caption="A rectangular mask drawn near the map corners." %}

## Ground Control Points

**Ground Control Points (GCPs)** guide Allmaps in aligning the scanned image (left side) with real-world geography (right side).

Use the **Georeference** tab to begin placing GCPs. To create one, find a location that clearly matches on both sides—such as a street intersection or the corner of a recognizable building. Click the same spot on both images.

{% include figure.html filename="georef_nz2_GCP.png" alt="Allmaps Editor showing matched ground control points on a scanned map and a modern basemap." caption="Adding ground control points in Allmaps Editor." %}

### GCP Best Practices for Urban Atlases

- **Avoid water bodies** – they change too much over time to be reliable.
- **Use roads and buildings** – as long as they haven’t been torn down or significantly altered.
- **Check your progress** – sometimes only a few GCPs are needed. Too many can actually introduce unwanted distortion. A good check-in is after placing 5–10 points.

These guidelines are adapted from the Leventhal Map & Education Center’s guide to georeferencing with Allmaps.[^1]

Remember, landscapes change: roads shift, water levels fluctuate, buildings appear and disappear. For example, using Brown Deer Road may not always be ideal:

{% include figure.html filename="MultiPage_BrownDeer.png" alt="An example showing misalignment caused by using Brown Deer Road as a control reference." caption="An example of problematic alignment using Brown Deer Road." %}

### What is this doing?

Behind the scenes, placing GCPs in Allmaps creates a [*Georeference Annotation*](https://iiif.io/api/extension/georef/).

{% include figure.html filename="georef_nz2_2.png" alt="A diagram comparing pixel coordinates in the image resource to geographic coordinates in real-world geometry." caption="Resource coordinates and geometry coordinates in a georeference annotation." %}

Each point creates a pair of values:
- **Resource coordinates** – pixel location in the image (e.g. 3017, 4367)
- **Geometry coordinates** – geographic location in longitude/latitude (e.g. 172.936215°E, 43.7589394°S)

Allmaps uses this data to calculate the warping or stretching needed to align the image over the map.

<!-- ![XKCD comic about coordinate precision](https://imgs.xkcd.com/comics/coordinate_precision.png) -->

For a humorous take on over-precise coordinates, see XKCD’s [“Coordinate Precision”](https://xkcd.com/2170/), by Randall Munroe.

{% include figure.html filename="coordinate_precision.png" alt="XKCD comic illustrating how extra decimal places imply unrealistic geographic precision" caption="XKCD, 'Coordinate Precision,' by Randall Munroe. Used under a Creative Commons Attribution-NonCommercial 2.5 license. Original: https://xkcd.com/2170/" %}


## Results

The **Results** tab gives you a preview of the map with georeferencing applied. It's a great way to check alignment and see if you're on the right track.

{% include figure.html filename="georef_nz5_result.png" alt="Allmaps Editor showing the georeferenced result preview." caption="Previewing georeferencing results in Allmaps." %}

The interface shown here reflects Allmaps as it appeared in fall 2025, so some controls may look slightly different now.

In the upper right, under **export**, you’ll see a drawer with more tools:

- Link to view in Allmaps Viewer
- Link to the annotation
- **Code** – shows the actual Georeference Annotation (JSON format). You can copy and reuse this in the Viewer.
- XYZ tile link (usable in web maps or GIS software)

On the bottom right, under **maps** you can find:

- **Transformation** and **Projection** to modify the spatial information 
- **GCP List** – lists all your points; delete ones that don't work

{% include figure.html filename="georef_nz6_Share.png" alt="The Allmaps share or export menu with links and map tools." caption="The share menu in Allmaps." %}

Click the **View in Allmaps Viewer** link in the share menu to continue.

##### Endnotes
<!-- [^1]: Firstname Lastname, *Book Title* (Place: Publisher, Year), page number. -->
[^1]: Leventhal Map & Education Center, “Georeference Urban Atlases with Allmaps,” *Cartinal*, accessed April 22, 2026, https://cartinal.leventhalmap.org/guides/georeferencing-with-allmaps.html#best-practices-for-creating-gcps.
