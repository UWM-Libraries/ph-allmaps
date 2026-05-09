# IIIF-powered georeferencing

[Georeferencing](https://en.wikipedia.org/wiki/Georeferencing) turns scanned maps into spatial data by corresponding the pixels in a digital map image to real geographic locations. The process emerged from the practice of transforming aerial and satellite photography into usable spatial data (for more detailed background, see ["Georeferencing and Georectification"](https://gistbok-topics.ucgis.org/DC-01-030) in the *GIS&T Body of Knowledge*). Today, historians and other humanities researchers georeference maps for things like data creation, change detection, and comparative analysis.

Traditionally, georeferencing requires uploading an image file, like a`JPG` or `TIFF`, to a geographic information system (GIS) or web client. The output typically includes a map in `GeoTIFF` format which can be overlaid on real-world geographies. You can check out existing *Programming Historian* lessons for explanations of these georeferencing workflows in [Map Warper](https://programminghistorian.org/en/lessons/introduction-map-warper), [QGIS 2.0](https://programminghistorian.org/en/lessons/georeferencing-qgis), and [KnightLab's StoryMap JS](https://programminghistorian.org/en/lessons/displaying-georeferenced-map-knightlab-storymap-js).

In this lesson, we introduce **[the Allmaps platform](https://allmaps.org)**: an open-source set of tools for curating and georeferencing digital maps.

{% include figure.html filename="https://allmaps.org/_astro/allmaps-viewer.BcO32y_r.jpg" alt="A georeferenced historic map, overlaid in the Allmaps platform" caption="A georeferenced historic map, overlaid in the Allmaps platform" %}

Allmaps is a free, publicly accessible, and web-based solution to georeferencing. Instead of requiring users to upload image files to a GIS or web client, Allmaps fetches image files directly from digital collections and dynamically warps them in a web browser. It's powered by a simple JSON file---a *georeference annotation*---which contains all the metadata necessary to warp a map. In addition to providing a simple interface for georeferencing, Allmaps provides a robust set of command-line tools and web-mapping libraries that advanced users can use to extend their research and visualization workflows.

You'll learn:

1. Why georeferencing can be useful for research and scholarship
2. The principles of IIIF, including how to identify IIIF maps
3. How to use Allmaps to view and georeference IIIF maps
4. Some of Allmaps' advanced features, including command-line tools
5. How to use Allmaps with open-source web mapping tools like Leaflet

## Why georeference?

There are many reasons why researchers and scholars georeference maps. Georeferenced maps make it easier to view change over time.

Discovery applications like the American Geographical Society Library's [Operation Birds Eye](https://uwm.maps.arcgis.com/apps/webappviewer/index.html?id=4e066bb8e5664d189ac3e77c26d21712) overlay 300 aerial photographs on modern satellite imagery, adding valuable context and enabling comparisons over time. Similarly, at the Leventhal Map & Education Center, the [Atlascope](https://atlascope.org) tool allows users to explore georeferenced urban atlases in a web map:

<iframe src="https://atlascope.org" width=100% height=500px></iframe>

Once a digitized map is aligned with geographic coordinates, it becomes possible to:

- Compare landscapes past and present, including streets, buildings, waterways, shorelines, neighborhoods, and boundaries
- Study change over time by overlaying maps from different times
- Join sheets from an atlas or map set into a larger composite
- Derive geospatial data for further analysis

{% include figure.html filename="georef_bok.png" alt="Historic map image aligned over a modern GIS basemap." caption="The georeferencing process places a digital image into a GIS. Source: https://gistbok-ltb.ucgis.org/page/27/concept/8131" %}

Traditional georeferencing solutions are built into geographic information systems (GIS) like QGIS or ArcGIS. Although GIS-based georeferencing tools can still useful for some workflows, they do have a steep learning curve, and in the case of ArcGIS, are quite expensive. This is where the International Image Interoperability Framework (IIIF )comes in: Allmaps' IIIF-powered georeferencing capabilities make it easier to do more with georeferenced maps, provided you have a basic handle on IIIF.

## What's IIIF?

[IIIF](https://iiif.io/) (pronounced "triple-eye-eff") is a set of open standards for delivering high-quality, attributed digital objects online at scale. IIIF provides a consistent way for institutions to share digital images, maps, manuscripts, artworks, and even audio/visual files across different platforms.

Rather than locking media inside specific viewers or software tools, IIIF offers a standardized, flexible way to deliver these resources to any compatible application. This means:

- A digitized map from one library can be viewed side-by-side with one from another institution.
- A scholar can annotate or compare high-resolution images without downloading large files.
- Tools like [Allmaps](https://allmaps.org/), [Mirador](https://projectmirador.org/), [Universal Viewer](https://universalviewer.io/), and [others](https://iiif.io/get-started/vendors/) can all read the same IIIF content.

At its core, then, IIIF enables *interoperability*, making it easier for cultural heritage institutions, educators, and developers to build user experiences around maps, photographs, documents, and other media from all over the world.

This lesson introduces more detail about IIIF than is ultimately necessary to get started georeferencing with Allmaps. 

## What problems does IIIF respond to?

The main problem that IIIF responds to is that digital images can be huge. Even physically small photos can have a large file size when they are stored in a digital repository system and served to a user---and that footprint grows with dimensions of the physical resource.

Consider the map below, *Kaart van het Brugse Vrije* by Pieter II Claeissens. It's physically massive. space. As Jan Trachet writes, [digitizing it](https://www.leventhalmap.org/articles/mapathon-1571/) required taking dozens of separate photographs and stitching them together in a software like Photoshop.

{% include figure.html filename="https://a-us.storyblok.com/f/1014956/1200x1601/7b80b6ad40/figure-1_photographing.jpg" alt="A photographer shoots a large wall map by Pieter II Claeissens." caption="Photographing the Claeissens wall map." %}

It also takes up many gigabytes of storage. Delivering multiple gigabytes of image data over the web is a pretty big payload---and that large payload is exactly what most libraries and museums are often dealing with.

In short, IIIF provides a solution to this problem of delivering large images over the web.

## How does IIIF work?

IIIF divides images into smaller regions of **tile pyramids**. When a digital repository implements IIIF, it produces tile pyramids that make each digitized image available at different resolutions, preserving the fidelity of deep zoom without having to deal with the payload of a massive file size all at once.

The interactive below, [by Jules Schoonman](https://observablehq.com/@allmaps/tile-pyramid), provides a great visualization for how tile pyramids work. An image is shown on the left, while its corresponding tile pyramid is shown on the right. As you zoom into the image, the relevant section of the tile pyramid is highlighted in gray.

Zoom into the image to try it out:

<iframe width="100%" height="470px" frameborder="0"
  src="https://observablehq.com/embed/@allmaps/tile-pyramid?cells=viz"></iframe>

In practice, IIIF images are usually delivered through viewers like [Mirador](https://projectmirador.org) or [OpenSeaDragon](https://openseadragon.github.io). Below, take a look at the AGSL's treasured [Leardo Mappamundi](https://collections.lib.uwm.edu/digital/collection/agdm/id/538/), embedded in a Mirador Viewer. Clicking on the expand arrows allows us to view the map in full-resolution detail directly in the browser---no need to download image files.

<iframe
  src="{{ '/part-1/leardo-mirador.html' | relative_url }}"
  title="Side-by-side Mirador comparison of the original and multispectral Leardo Mappamundi"
  width="100%"
  height="650"
  allowfullscreen>
</iframe>

## The IIIF manifest

Allmaps builds on the IIIF protocol to warp IIIF maps directly in a web browser. In order to georeference a map in Allmaps, you need something called a **IIIF manifest**.

A "manifest" is the prime unit in IIIF. Like the manifest for a plane or a ship, IIIF manifests contain information about their cargo. In our case, the "cargo" includes the pixels of the digital resource, its metadata, and any optional parameters for how the image should be displayed.

Once you have the manifest, you can do a lot with it. Take, for instance, the Leardo Mappamundi we mentioned above. Its digital collection record is:

> !TIP
>
> Click each of the URLs to open them in a new tab as you go.

<a target="blank" href="https://collections.lib.uwm.edu/digital/collection/agdm/id/538/">

```html
https://collections.lib.uwm.edu/digital/collection/agdm/id/538/
```

</a>

The Leardo map's IIIF manifest is listed at the bottom of the page, near the <img src="../../images/iiif.png" style="border:none;vertical-align:middle;" width=25px> logo. If you open the link below, you'll see a big jumble of [JSON](https://www.json.org/json-en.html) (JavaScript Object Notation) data: 

<a target="blank" href="https://collections.lib.uwm.edu/iiif/info/agdm/538/manifest.json">

```html
https://collections.lib.uwm.edu/iiif/info/agdm/538/manifest.json
```

</a>

That big JSON jumble is our IIIF Manifest for the Leardo Mappamundi. It contains metadata about the object itself, like the title of the work and its publication date, but it also includes information about the IIIF image (like width and height in pixels).

Open the manifest in a new tab and scroll through its contents. Can you find these values? What other metadata do you see?

Now that you have the manifest, you can we could point to the [full size image](https://collections.lib.uwm.edu/digital/iiif/agdm/538/full/full/0/default.jpg) at the URL `https://collections.lib.uwm.edu/digital/iiif/agdm/538/full/full/0/default.jpg`---but we can also tweak this URL, every so slightly, to deliver a smaller version of the image:

<a target="blank" href="https://cdm17272.contentdm.oclc.org/iiif/2/agdm:538/full/1200,/0/default.jpg">

```html
https://cdm17272.contentdm.oclc.org/iiif/2/agdm:538/full/1200,/0/default.jpg
```

</a>

Here, we've replaced `/full/full/0/` with `/full/1200,/0/`, which tells any browser or application requested this URL to fetch the image at a maximum resolution of 1,200 pixels wide.

We could also deliver a smaller, zoomed-in crop of the source image by specifying a two-pixel bounding box, turning `/full/1200,/0/` into `/3416,3568,526,492/1200,/0`:

<a target="blank" href="https://cdm17272.contentdm.oclc.org/iiif/2/agdm:538/3416,3568,526,492/1200,/0/default.jpg">

```html
https://cdm17272.contentdm.oclc.org/iiif/2/agdm:538/3416,3568,526,492/1200,/0/default.jpg
```

</a>

Finally, we can even pass a variety of parameters like rotation. In the image below, we've added the value 280 `/4662,3731,562,772/1200/280/`:

```html
https://cdm17272.contentdm.oclc.org/iiif/2/agdm:538/4662,3731,562,772/1200/280/default.jpg
```

All of these things are possible because of IIIF's built-in application programming interfaces (or APIs), which allow you to query images according a different parameters in the URL. It's obviously difficult to manipulate the values in the URL by hand, but thankfully, the presence of an API makes it possible to build applications on top of the IIIF protocol. One example is the Leventhal Center's [IIIF Tools](https://iiif-tools.leventhal.center), which provides a user-friendly interface for manipulating the IIIF Image API and constructing different image endpoints.

To test your knowledge of IIIF, try the following challenge:

1. Pick another map from [AGSL's digital collections](https://uwm.edu/lib-collections/agsl-digital-map-collection/)
2. Copy its IIIF manifest
3. Paste the manifest into the [IIIF Tools](https://iiif-tools.leventhal.center) app
4. Load the image
5. Copy the URL labeled "IIIF Endpoint" (this is the "Image API endpoint")
6. Paste it into the visualizer below to view the structure of its IIIF tile pyramid

<iframe width="100%" height="709" frameborder="0"
  src="https://observablehq.com/embed/@allmaps/tile-pyramid?cells=viewof+tileSourceUrl%2Cviz"></iframe>

## IIIF map collections

Allmaps uses these APIs (and others) to fetch IIIF images from digital repository servers and warp them in a web browser. The Allmaps platform consists of two main apps: [Allmaps Editor](https://editor.allmaps.org), which allows you to georeference a IIIF map, and [Allmaps Viewer](https://viewer.allmaps.org), which allows you to view them.

These tools are ideal for large-scale maps such as city, county, state, or country maps, including:

- Urban atlases like fire insurance atlases, plats, and quartersectional atlases
- County and state maps, highway maps, and recreation maps
- Topographic or thematic map series

All of the maps in [AGSL](https://uwm.edu/lib-collections/agsl-digital-map-collection/) and [LMEC](https://collections.leventhalmap.org) digital collections are IIIF compliant. Additionally, the Allmaps project maintains a [list of IIIF map collections](https://github.com/allmaps/iiif-map-collections/blob/main/iiif-map-collections.yml) across the world. Any of the collections that you see in this list should be easy to work with in Allmaps.

Other websites may require more sleuthing to find the manifest. On the [David Rumsey Map Collection](https://www.davidrumsey.com), the IIIF manifest is listed under the share menu:

{% include figure.html filename="rumsey.png" alt="David Rumsey Map Collection share menu showing IIIF manifest options." caption="Finding a IIIF manifest in the David Rumsey Map Collection." %}

If you're comfortable installing a browser extension, [DetektIIIF](https://seige.digital/en/detektiiif/) makes it really easy to track down a IIIF manifest anywhere on the internet. Basically, if a IIIF image is present on a website, DetektIIIF will sniff it out and give you its manifest.