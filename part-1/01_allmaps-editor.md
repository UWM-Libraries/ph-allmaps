
## Allmaps Editor

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

{% include figure.html filename="georef_nz3_Mask.png" alt="Screenshot of Allmaps Editor with a polygon clipping mask drawn around the map area." caption="Drawing a clipping mask in Allmaps Editor." %}

It's possible your image includes multiple maps! Each map gets its own mask.
In the figure below, three maps are defined from a single image:
The main map image (labeled 1) and two inset map areas (labeled 2 and 3).

{% include figure.html filename="greenpoint.jpg" alt="Scanned page showing multiple maps on one sheet, each of which would need its own mask." caption="A scanned page with multiple maps." %}

Much of the time, your mask will simply be a rectangle drawn just inside the map's neatline.

{% include figure.html filename="georef_nz4_MaskCorner.png" alt="Screenshot of a simple rectangular mask drawn just inside a map's neatline." caption="A rectangular mask drawn near the map corners." %}

## Ground Control Points

Ground Control Points (GCPs) guide Allmaps in aligning the scanned image (left side) with real-world geography (right side).

Use the Georeference tab to begin placing GCPs.
To create one, find a location that clearly matches on both sides, such as a street intersection or the corner of a recognizable building.
Click the same spot on both images.
In the figure below, note the pink dot labeled 2 on both sides of the image, in this case an easily identifiable location near Cape Reinga on the Aupōuri Peninsula of New Zealand.

{% include figure.html filename="georef_nz2_GCP.png" alt="Screenshot of Allmaps Editor with matching ground control points placed on the scanned map and the modern basemap." caption="Adding ground control points in Allmaps Editor." %}

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
{% include figure.html filename="georef_nz2_2.png" alt="Diagram showing how pixel coordinates in the image correspond to geographic coordinates in the georeference annotation." caption="Resource coordinates and geometry coordinates in a georeference annotation." %}

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

{% include figure.html filename="georef_nz5_result.png" alt="Screenshot of the Results tab in Allmaps Editor showing the georeferenced preview over the basemap." caption="Previewing georeferencing results in Allmaps." %}

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
{% include figure.html filename="georef_nz6_Share.png" alt="Screenshot of the Allmaps export drawer showing links to the viewer, annotation, code, and tile tools." caption="The share menu in Allmaps." %}

Click the *View in Allmaps Viewer* link in the Export menu to continue.
Next we will work with the map in Allmaps Viewer.

##### Endnotes
<!-- [^1]: Firstname Lastname, *Book Title* (Place: Publisher, Year), page number. -->
[^1]: Leventhal Map & Education Center, “Georeference Urban Atlases with Allmaps,” *Cartinal*, accessed April 22, 2026, https://cartinal.leventhalmap.org/guides/georeferencing-with-allmaps.html#best-practices-for-creating-gcps.
