# Allmaps Editor

Let's get started with some georeferencing.

First, launch the Allmaps Editor by going to [editor.allmaps.org](https://editor.allmaps.org). You can choose a map to georeference by either:

1. Entering a IIIF Manifest URL in the text box at the top of the page
2. Scrolling down to find a map in one of the featured collections

Allmaps uses metadata in the IIIF manifest to fetch image data from the host institution's servers.

{% include figure.html filename="manifestURL.png" alt="UWM digital collection item page showing the IIIF Manifest URL field." caption="Finding the IIIF Manifest URL in the UWM digital collection." %}

This lesson will use a lot of screenshots from georeferencing this [chart of New Zealand](https://collections.lib.uwm.edu/digital/collection/agdm/id/3198/), but you should pick a different map to geoference.

## Draw Mask

The first step is adding a mask. This involves drawing a line around the map areas of the document to exclude the collar or marginalia. The mask identifies parts of the scanned image that you want to georeference. Only parts of the image inside the mask will be warped. In the Allmaps lexicon, one mask defines a "map" on a region of the "image".

Use the "Draw Mask" tab to add a mask. Click to add points, and double-click to close the polygon. If you mess up, click "Cancel" to start over.

In the figure below, note that the pink line defines the mask and excludes the map collar from the defined map.

{% include figure.html filename="georef_nz3_Mask.png" alt="Screenshot of Allmaps Editor with a polygon mask drawn around the map area." caption="Drawing a clipping mask in Allmaps Editor." %}

It's possible your image includes multiple maps! If so, each map gets its own mask.

In the figure below, three maps are defined from a single image: the main map image (labeled 1) and two inset map areas (labeled 2 and 3).

{% include figure.html filename="greenpoint.jpg" alt="Scanned page showing multiple maps on one sheet, each of which would need its own mask." caption="A scanned page with multiple maps." %}

Much of the time, your mask will simply be a rectangle drawn just inside the map's neatline.

{% include figure.html filename="georef_nz4_MaskCorner.png" alt="Screenshot of a simple rectangular mask drawn just inside a map's neatline." caption="A rectangular mask drawn near the map corners." %}

## Georeference

Ground control points (GCPs) guide Allmaps in aligning the scanned image (left side) with real-world geography (right side).

Use the "Georeference" tab to begin placing GCPs.

To create one, find a location that clearly matches on both sides, such as a street intersection, the corner of a recognizable building, or a stable political boundary.

Click the same spot on both images.

In the figure below, note the pink dot labeled `2` on both sides of the image, in this case an easily identifiable location near Cape Reinga on the Aupōuri Peninsula of New Zealand.

{% include figure.html filename="georef_nz2_GCP.png" alt="Screenshot of Allmaps Editor with matching ground control points placed on the scanned map and the modern basemap." caption="Adding ground control points in Allmaps Editor." %}

When placing ground control points---especially for cartographic corpora like urban atlases---consider the following:

- **Avoid water bodies**: they change too much over time to be reliable.
- **Use roads and buildings**: as long as they haven’t been torn down or significantly altered.
- **Check your progress**: sometimes only a few GCPs are needed. Too many can actually introduce unwanted distortion. A good check-in is after placing 5–10 points.

Remember, landscapes change: roads shift, water levels fluctuate, buildings are raized and replaced.[^1]

### The Georeference Annotation

Behind the scenes, placing GCPs in Allmaps creates a **[Georeference Annotation](https://iiif.io/api/extension/georef/)**, a standard format for storing geospatial information associated with a IIIF image. The Annotation specification is maintained by the [IIIF Consortium](https://iiif.io).

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

Allmaps uses this data to calculate the warping or stretching needed to align the map image in geographic space. 6-digit coordinate precision is probably overkill, but hey... it gives us an excuse to use [one of our favorite xkcd comics](https://xkcd.com/2170):

{% include figure.html filename="https://imgs.xkcd.com/comics/coordinate_precision_2x.png" alt="A humorous comic that highlights the diminishing returns of latitude/longitude precision beyond four decimal points" caption="Coordinate precision, by xkcd" %}

Georeference annotations are automatically created when you draw a mask or place a control point. From Allmaps Editor, here's how you can locate a map's georeference annotation:

1. Click the green "Export" button
2. Click the up-right arrow by the "Georeference annotation" to open it in a new tab

Here's the georeference annotation for that chart of New Zealand:

<a target="blank" href="https://annotations.allmaps.org/images/ed34bf1e16463906">

```html
https://annotations.allmaps.org/images/ed34bf1e16463906
```

</a>

That ID, `ed34bf1e16463906`, is called an "Allmaps ID." It is unique to the Allmaps data ecosystem. It's generated by passing the IIIF manifest through a hashing algorithm that produces a unique, 16-digit alphanumeric identifier.

Open the annotation in a new tab and inspect it. Can you make sense of what each `key` and each `value` are communicating? Can you locate the resource coordinates and geometry coordinates?

{% include figure.html filename="georef_nz2_2.png" alt="Diagram showing how pixel coordinates in the image correspond to geographic coordinates in the georeference annotation." caption="Resource coordinates and geometry coordinates in a georeference annotation." %}

## Results

The "Results" tab displays a preview of the map with georeferencing applied. It's a great way to check alignment and see if you're on the right track.

Notice in the figure below how the maps is displayed with it's collar removed beyond the neatline and the shape is no longer rectangular and has taken on a parallelogram shape.

{% include figure.html filename="georef_nz5_result.png" alt="Screenshot of the Results tab in Allmaps Editor showing the georeferenced preview over the basemap." caption="Previewing georeferencing results in Allmaps." %}

In the upper right, under *Export*, you’ll see a drawer with more tools:

- Link to view in Allmaps Viewer
- Link to the annotation
- A `</> Code` button shows the full Georeference Annotation as a popup
- XYZ tiles (usable in web maps or GIS software)

On the bottom right, under *Maps* you can find:

- **Transformation** and **Projection** to modify how the map is warped and how its coordinates are stored
- **GCP List** – lists all your points; delete ones that don't work

The *Transformation* option controls the algorithm Allmaps uses to warp the image from your control points. Different algorithms will produce different results. Some stretch or distort the image more than others, so changing the transformation can change how you interpret the map, not just how it looks.

The *Projection* option lets you choose the projection used for the map's geospatial coordinates. These settings are written into the georeference annotation, so they become part of the map data that Viewer, the tile server, and other Allmaps tools read later.

Compare transformation and projection options as different interpretations of the same control points, and pay attention to places where the map stretches, bends, or preserves local detail.

<!-- TODO: Need updated screenshot. -->
{% include figure.html filename="georef_nz6_Share.png" alt="Screenshot of the Allmaps export drawer showing links to the viewer, annotation, code, and tile tools." caption="The share menu in Allmaps." %}

Click the *View in Allmaps Viewer* link in the Export menu to continue.
Next we will work with the map in Allmaps Viewer.

##### Endnotes

<!-- [^1]: Firstname Lastname, *Book Title* (Place: Publisher, Year), page number. -->

[^1]: Leventhal Map & Education Center, “Georeference Urban Atlases with Allmaps,” *Cartinal*, accessed April 22, 2026, https://cartinal.leventhalmap.org/guides/georeferencing-with-allmaps.html#best-practices-for-creating-gcps.
