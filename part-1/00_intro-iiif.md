# Georeferencing and IIIF

## What is Georeferencing?

[Georeferencing](https://en.wikipedia.org/wiki/Georeferencing) is the process of overlaying a digital image on a map by matching pixels on the image to real geographic locations. This is commonly done with aerial and satellite photography to transform photographs into usable spatial data.

A few other Programming Hisotrian lessons have already worked with georeferencing workflows:

- [Displaying a Georeferenced Map in KnightLab's StoryMap JS](https://programminghistorian.org/en/lessons/displaying-georeferenced-map-knightlab-storymap-js)
- [Introduction to Map Warper](https://programminghistorian.org/en/lessons/introduction-map-warper)
- [Georeferencing in QGIS 2.0](https://programminghistorian.org/en/lessons/georeferencing-qgis)

Georeferencing turns scanned maps into spatial data. Once a map is aligned with geographic coordinates, it becomes possible to:
- Compare landscapes past and present, including streets, buildings, waterways, shorelines, neighborhoods, and boundaries.
- Study change over time by overlaying maps from different times.
- Join sheets from an atlas or map set into a larger view of an area.

{% include figure.html filename="georef_bok.png" alt="Historic map image aligned over a modern GIS basemap." caption="The georeferencing process places a digital image into a GIS. Source: https://gistbok-ltb.ucgis.org/page/27/concept/8131" %}

For objects with multiple sheets or pages—such as urban atlases, georeferencing can make the experience easier and more engaging.

A project by the Leventhal Map & Education Center at the Boston Public Library used Allmaps
to georeference urban atlas sheets for their [Atlascope application](https://www.atlascope.org/).

{% include figure.html filename="Atlascope.png" alt="Atlascope viewer showing georeferenced urban atlas sheets over a modern map." caption="Georeferenced atlas sheets in Atlascope." %}

Traditionally, georeferencing has been done in **GIS** (Geographic Information Systems).
Some workflows will still benefit from the power of desktop GIS applications, but the learning curve is considerable.
For more detailed background, see [*Georeferencing and Georectification*](https://gistbok-topics.ucgis.org/DC-01-030) in the GIS&T Body of Knowledge.

Thanks to modern, accessible web-mapping tools, platforms like Allmaps now make this process possible for non-experts right in a browser.

## What is IIIF?

IIIF (pronounced "triple-eye-eff"), an initialism meaning [International Image Interoperability Framework](https://iiif.io/),
is a set of open standards for delivering high-quality, attributed digital objects online at scale.
IIIF provides a consistent way for institutions to share digital images, maps, manuscripts, artworks, and even audio/visual files across different platforms.
Rather than locking media inside specific viewers or software tools, IIIF offers a standardized, flexible way to deliver these resources to any compatible application.

This means that:

- A digitized map from one library can be viewed side-by-side with one from another institution.
- A scholar can annotate or compare high-resolution images without downloading large files.
- Tools like
[Allmaps](https://allmaps.org/),
[Mirador](https://projectmirador.org/),
[Universal Viewer](https://universalviewer.io/), and
[others](https://iiif.io/get-started/vendors/)
can all read the same IIIF content.

At its core, IIIF enables interoperability—making it easier for cultural heritage institutions, educators, and developers to build user experiences around
maps, photographs, documents, and other media from all over the world.

Learn more at [iiif.io](https://iiif.io/get-started/how-iiif-works/).

<!-- TODO: Compare "old" and "new" multispectral images of the Leardo Mappamundi in a Mirador viewer. -->

Take a look at the AGSL's treasured [Leardo Mappamundi](https://collections.lib.uwm.edu/digital/collection/agdm/id/538/).
Clicking on the expand arrows allows us to view the map in full-resolution detail directly in the browser.
No need to download image files.

<iframe
  src="{{ '/part-1/leardo-mirador.html' | relative_url }}"
  title="Side-by-side Mirador comparison of the original and multispectral Leardo Mappamundi"
  width="100%"
  height="650"
  allowfullscreen>
</iframe>

## Finding IIIF maps to use in Allmaps

Allmaps works best with relatively large-scale maps such as city, county, state, or country maps.
While it’s possible to georeference small-scale maps (like world maps), distortion introduced by the georeferencing process—especially in Web Mercator projection—can make them harder to work with.

Allmaps excels at georeferencing:
- Urban atlases like fire insurance atlases, plats, and quartersectional atlases
- County and state maps, highway maps, and recreation maps
- Topographic or thematic map series

<!-- TODO: Connect these source types to scholarly examples. -->

### IIIF Collections

The IIIF Consortium lists compliant collections at [this link](https://iiif.io/guides/finding_resources/).
When launching the
<!-- TODO: Confirm with Bert that this feature will be around a while. -->
[Allmaps Editor](https://editor.allmaps.org),
you'll see maps hosted by various Allmaps partners that are waiting to be georeferenced.

To georeference a specific map from a IIIF compliant collection, copy its IIIF Manifest URL located at the bottom of each item page.

The IIIF Manifest URL links to a JSON file that packages metadata information to display, annotate, and navigate the digital object.
Allmaps uses this information to fetch the image information from the hosting institution's servers.
<!-- TODO: Confirm above technical description. -->\

{% include figure.html filename="manifestURL.png" alt="UWM digital collection item page showing the IIIF Manifest URL field." caption="Finding the IIIF Manifest URL in the UWM digital collection." %}

<!-- TODO: Consider if we want to include the browser extension at all. -->

Other websites may require more sleuthing to find the manifest.
On the David Rumsey Collection, it's listed under the share menu.

{% include figure.html filename="rumsey.png" alt="David Rumsey Map Collection share menu showing IIIF manifest options." caption="Finding a IIIF manifest in the David Rumsey Map Collection." %}

If it’s not visible, tools like the [DetectIIIF browser extension](https://seige.digital/en/detektiiif/) can help.
