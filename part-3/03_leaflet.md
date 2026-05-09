# Using Allmaps with Leaflet

Allmaps provides three different libraries for loading georeferenced maps as web map layers. You can use Leaflet, OpenLayers, or MapLibre.

This lesson gives an overview for the Allmaps Leaflet Plugin, but once you've got this figured out, the others should be easy to adapt.

The Allmaps Leaflet plugin, described in greater detail in [this Observable Notebook](https://observablehq.com/@allmaps/leaflet-plugin) as well as the [official Allmaps documentation](https://allmaps.org/docs/packages/leaflet/#_top), is distributed via [npm](https://www.npmjs.com/package/@allmaps/leaflet).

Let's get into it...

## Copy the template

The `allmaps-leaflet-demo` folder in this repository contains three files that provide a pretty minimal working demo of the Allmaps Leaflet plugin in a simple Leaflet web map. Those files are:

- `index.html`: the web page structure for our simple web map
- `script.js`: the necessary JavaScript for creating a Leaflet map with two layers, a base map and an Allmaps overlay
- `style.css`: a CSS file that makes the map visible

Open the `allmaps-leaflet-demo` folder in a text editor like VS Code. If need be, install the "Live Server" extension by Ritwick Dey, which allows you to view the web map as local files in a web browser. You can install the extension by searching "Live Server" in the "Extensions" tab (the little building blocks) of VS Code.

If you click "Go Live" in the bottom right-hand corner of VS Code, the Leaflet web map should open in your default web browser.

The rest of this part of the lesson will explain what's going on in the code. We'll explain some of the basic concepts behind HTML, JavaScript, and CSS, but space constrains us from going into greater detail.

If you want to learn more about Leaflet, check out these *Programming Historian* lessons by [Kim Pham on geocoding](https://programminghistorian.org/en/lessons/mapping-with-python-leaflet) and [Stephanie J. Richmond and Tommy Tavenner on maps of correspondences](https://programminghistorian.org/en/lessons/using-javascript-to-create-maps). 

## index.html

Open the `index.html` file. This file contains the structure for our web page.

The `head` tags contain a lot of important information. That's where we're actually fetching all the Leaflet code, as well as loading our local files.

Line 8 loads the `style.css` file:

```html
<link rel="stylesheet" href="style.css" />
```

Lines 11 and 12 load Leaflet and the Allmaps Leaflet plugins:

```html
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
<script type="module" src="https://cdn.jsdelivr.net/npm/@allmaps/leaflet/dist/bundled/allmaps-leaflet-1.9.umd.js"></script>
```

Line 15 loads Lefalet's external CSS library:

```html
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
```

And finally, line 18 loads our local `script.js`, where we are actually creating the web map:

```html
<script type="module" src="script.js"></script>
```

The `body` tags contain a minimal structure for the map itself:

```html
<body>
  <div id="wrapper">
    <h1>Hi, Allmaps Leaflet Plugin!</h1>
    <div id="map"></div>
  </div>
</body>
```

Here, `<div id="wrapper">` creates a nice container for our map by applying these CSS values to the page...

```css
#wrapper {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  display: flex;
  flex-direction: column;
}
```

... and then, `<div id="map"></div>` creates a fullscreen map inside of our parent `div`, according to this CSS:

```css
#map {
  width: 100%;
  height: 100vw;
  z-index:1;
}
```

Try opening the `style.css` file to inspect this stuff directly, or even tweaking some of the values as a matter of experimentation.

## script.js

The Allmaps Leaflet plugin uses georeference annotations to overlay maps. We'll be using this georeference annotation...

```html
https://annotations.allmaps.org/manifests/cfb327e4b43395e3
```

... which corresponds to [this map of Boston](https://collections.leventhalmap.org/search/commonwealth:3f463198b):

{% include figure.html filename="https://iiif.digitalcommonwealth.org/iiif/2/commonwealth:3f463c23b/full/1200,/0/default.jpg" alt="A map of Boston from 1838, by T.G. Bradford" caption="A map of Boston from 1838, by T.G. Bradford (Source: https://collections.leventhalmap.org/search/commonwealth:3f463198b)" %}

### Map setup

To instantiate a Leaflet map, define a variable as `L.map("map", { ... })`, where `...` includes the map's parameters, like where it's centered, its starting zoom, and other features.

We define our map like this:

```js
const map = L.map("map", {
  center: [42.3518, -71.05],
  zoom: 13,
  minZoom: 7,
  maxZoom: 24,
  zoomControl: false,
});
```

### Add a base map

We want to add a base map to our Leaflet map. We'll use OpenStreetMap's free XYZ tiles, provided at <https://tile.openstreetmap.org/{z}/{x}/{y}.png>.

First, we define options for the XYZ tiles:

```js
let tileLayerDetails = [
  {
    tileSize: 512,
    zoomOffset: -1,
    minZoom: 14,
    maxZoom: 24,
    crossOrigin: true,
  },
];
```

Then, we can add it to the map with a single line of code:

```js
let streets_base = L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png").addTo(map);
```

Next, now that our map has been instantiated and contains an OpenStreetMap base, we define two new variables:

- `annotationUrl` contains the URL of the georeference annotation 
- `WarpedMapLayer` creates a new `WarpedMapLayer` and adds it to the map

```js
let annotationUrl = 'https://annotations.allmaps.org/manifests/cfb327e4b43395e3';
let warpedMapLayer = new Allmaps.WarpedMapLayer(annotationUrl).addTo(map);
```

In a [vanilla JS setup](https://stackoverflow.com/questions/20435653/what-is-vanillajs) like ours, note that you must call the `WarpedMapLayer` method by prefixing it with `Allmaps.`. This syntax would be slightly different---and it would more closely resemble the code snippets found on the [`@allmaps/leaflet` npm documentation](https://www.npmjs.com/package/@allmaps/leaflet)---if you installed it with `npm` and used it in a front-end framework like Svelte, Vue, or React.

At this point, the map is basically done, and our georeference annotation should appear 

### Add the layer list

All that's left is to create a layer list, which allows us to toggle the map's visibility on and off, with these three lines of code:

```js
let base = { "OpenStreetMap": streets_base };
let overlay = { "Allmaps overlay": warpedMapLayer };
let layerControl = L.control.layers(base, overlay).addTo(map);
```

In Leaflet-speak, these are called "layer controls," and you can [read more about them here](https://leafletjs.com/examples/layers-control/).

## Final map

<iframe src="allmaps-leaflet-demo/index.html" width=100% height="500px"></iframe>

Try adding different annotations (just note you'll have to update the `center` array, which is hard-coded to a lat/long pair for Boston).