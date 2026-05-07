# Georeferencing and IIIF

[Georeferencing](https://en.wikipedia.org/wiki/Georeferencing) turns scanned maps into spatial data by corresponding the pixels in a digital map image to real geographic locations. While georeferencing emerged from the practice of transforming aerial and satellite photography into usable spatial data, the "spatial turn" in the humanities has found historians and other researchers.

Traditionally, georeferencing requires uploading an image file, like a`JPG` or `TIFF`, to a geographic information system (GIS) or web client. The output typically includes a map in `GeoTIFF` format which can be overlaid on real-world geographies.

You can check out existing *Programming Historian* lessons for explanations of these georeferencing workflows in [Map Warper](https://programminghistorian.org/en/lessons/introduction-map-warper), [QGIS 2.0](https://programminghistorian.org/en/lessons/georeferencing-qgis), and [KnightLab's StoryMap JS](https://programminghistorian.org/en/lessons/displaying-georeferenced-map-knightlab-storymap-js).

In Part 1 of this three-part lesson, you'll learn:

1. Why georeferencing can be useful for research and scholarship
2. The principles of IIIF, including how to identify IIIF maps
3. How to use Allmaps to georeference and view IIIF maps

## Why georeference?

There are three reasons why researchers and scholars may be interested in georeferencing as a method. First, georeferenced maps facilitate comparisons of change over time. Second, georeferenced maps 

The American Geographical Society Library uses georeferencing of aerial photography in the
[Operation Birds Eye](https://uwm.maps.arcgis.com/apps/webappviewer/index.html?id=4e066bb8e5664d189ac3e77c26d21712)
discovery application. While anyone is welcome to flip through the nearly 300 photographs that make up this collection, seeing them overlaid on modern satellite imagery adds valuable context and enables comparisons over time.

Similarly, at the Leventhal Map & Education Center, the [Atlascope](https://atlascope.org) tool allows users to compare georeferenced urban atlases in a web mapping environment:

<iframe src="https://atlascope.org" width=100% height=500px></iframe>

Once a map is aligned with geographic coordinates, it becomes possible to:

- Compare landscapes past and present, including streets, buildings, waterways, shorelines, neighborhoods, and boundaries.
- Study change over time by overlaying maps from different times.
- Join sheets from an atlas or map set into a larger view of an area.

{% include figure.html filename="georef_bok.png" alt="Historic map image aligned over a modern GIS basemap." caption="The georeferencing process places a digital image into a GIS. Source: https://gistbok-ltb.ucgis.org/page/27/concept/8131" %}

For objects with multiple sheets or pages—such as urban atlases, georeferencing can make the experience easier and more engaging.

Traditionally, georeferencing has been done in **GIS** (Geographic Information Systems).
Some workflows will still benefit from the power of desktop GIS applications, but the learning curve is considerable.

For more detailed background, see [*Georeferencing and Georectification*](https://gistbok-topics.ucgis.org/DC-01-030) in the GIS&T Body of Knowledge.

Thanks to modern, accessible web mapping tools, platforms like Allmaps now make this process possible directly in a web browser.

## What's IIIF?

IIIF (pronounced "triple-eye-eff"), an initialism meaning [International Image Interoperability Framework](https://iiif.io/), is a set of open standards for delivering high-quality, attributed digital objects online at scale. IIIF provides a consistent way for institutions to share digital images, maps, manuscripts, artworks, and even audio/visual files across different platforms.

Rather than locking media inside specific viewers or software tools, IIIF offers a standardized, flexible way to deliver these resources to any compatible application. This means:

- A digitized map from one library can be viewed side-by-side with one from another institution.
- A scholar can annotate or compare high-resolution images without downloading large files.
- Tools like [Allmaps](https://allmaps.org/), [Mirador](https://projectmirador.org/), [Universal Viewer](https://universalviewer.io/), and [others](https://iiif.io/get-started/vendors/) can all read the same IIIF content.

At its core, then, IIIF enables *interoperability*, making it easier for cultural heritage institutions, educators, and developers to build user experiences around maps, photographs, documents, and other media from all over the world.

## What problems does IIIF respond to?

Digital images can be huge. Even physically small photos can have a large file size when they are stored in a digital repository system and served to a user. The massive map shown here, *Kaart van het Brugse Vrije* by Pieter II Claeissens, takes up many gigabytes of storage space. [Digitizing it](https://www.leventhalmap.org/articles/mapathon-1571/) required taking dozens of separate photographs and stitching them together in a software like Photoshop.

{% include figure.html filename="https://a-us.storyblok.com/f/1014956/1200x1601/7b80b6ad40/figure-1_photographing.jpg" alt="A photographer shoots a large wall map by Pieter II Claeissens." caption="Photographing the Claeissens wall map." %}

Delivering a multi-gigabyte image through a web application is a really big payload. Unfortunately, that's exactly what most libraries and museums are often dealing with---very big, high-resolution digital versions of their physical materials---and those libraries and museums want those digital versions to be accessible to their patrons.

## How does IIIF work?

Implementing IIIF---for example, in a library or museum's digital repository---divides images into smaller regions of **tile pyramids**. These pyramids make the image available at different resolutions, preserving the fidelity of deep zoom without having to deal with the payload of a massive file size all at once.

The interactive below provides a great visualization for how tile pyramids work. An image is shown on the left, while its corresponding tile pyramid is shown on the right. As you zoom into the image, the relevant section of the tile pyramid is highlighted in gray.

Zoom into the image to try it out:

<iframe width="100%" height="470px" frameborder="0"
  src="https://observablehq.com/embed/@allmaps/tile-pyramid?cells=viz"></iframe>

<!-- TODO: Compare "old" and "new" multispectral images of the Leardo Mappamundi in a Mirador viewer. -->

Take a look at the AGSL's treasured [Leardo Mappamundi](https://collections.lib.uwm.edu/digital/collection/agdm/id/538/). Clicking on the expand arrows allows us to view the map in full-resolution detail directly in the browser---no need to download image files.

<!-- Is this Mirador HTML file meant to be located somewhere else in the repo? -->

<iframe
  src="{{ '/part-1/leardo-mirador.html' | relative_url }}"
  title="Side-by-side Mirador comparison of the original and multispectral Leardo Mappamundi"
  width="100%"
  height="650"
  allowfullscreen>
</iframe>

## Allmaps and IIIF

Allmaps builds on the IIIF protocol to 

Allmaps works best with relatively large-scale maps such as city, county, state, or country maps.

While it’s possible to georeference small-scale maps (like world maps), distortion introduced by the georeferencing process---especially in Web Mercator projection---can make them harder to work with.

Allmaps excels at georeferencing:

- Urban atlases like fire insurance atlases, plats, and quartersectional atlases
- County and state maps, highway maps, and recreation maps
- Topographic or thematic map series

The Allmaps project maintains a [list of IIIF maps](https://github.com/allmaps/iiif-map-collections/blob/main/iiif-map-collections.yml).

<!-- TODO: Connect these source types to scholarly examples. -->

## IIIF Collections

The IIIF Consortium lists compliant collections at [this link](https://iiif.io/guides/finding_resources/).

When launching the
<!-- TODO: Confirm with Bert that this feature will be around a while. -->
[Allmaps Editor](https://editor.allmaps.org), you'll see maps hosted by various Allmaps partners that are waiting to be georeferenced.

To georeference a specific map from a IIIF compliant collection, copy its IIIF Manifest URL located at the bottom of each item page.

The IIIF Manifest URL links to a JSON file that packages metadata information to display, annotate, and navigate the digital object.

Allmaps uses this information to fetch the image information from the hosting institution's servers.
<!-- TODO: Confirm above technical description. -->\

{% include figure.html filename="manifestURL.png" alt="UWM digital collection item page showing the IIIF Manifest URL field." caption="Finding the IIIF Manifest URL in the UWM digital collection." %}

<!-- TODO: Consider if we want to include the browser extension at all. -->

Other websites may require more sleuthing to find the manifest.

On the David Rumsey Collection, it's listed under the share menu.

{% include figure.html filename="rumsey.png" alt="David Rumsey Map Collection share menu showing IIIF manifest options." caption="Finding a IIIF manifest in the David Rumsey Map Collection." %}

If it’s not visible, tools like the [DetektIIIF browser extension](https://seige.digital/en/detektiiif/) can help.