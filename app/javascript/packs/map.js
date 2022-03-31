mapboxgl.accessToken = 'pk.eyJ1IjoibG92cm9vIiwiYSI6ImNsMWMxMmFvdTAwZnkza3F4NWZuN3B5dzkifQ.EejjM3kd7rMokb1sqS6zhg';

function apiGet(method, query) {
    return new Promise(function (resolve, reject) {
        var otmAPI =
            "https://api.opentripmap.com/0.1/en/places/" +
            method +
            "?apikey=" + "5ae2e3f221c38a28845f05b63491fa7c34e2bf26d286b76a8e47f69d";
        if (query !== undefined) {
            otmAPI += "&" + query;
        }
        fetch(otmAPI)
            .then(response => response.json())
            .then(data => resolve(data))
            .catch(function (err) {
                console.log("Fetch Error :-S", err);
            });
    });
}


var map = new mapboxgl.Map({
    container: "map",
    style: "mapbox://styles/mapbox/streets-v11",
    center: [15.110658, 46.362274],
    zoom: 8
});

map.addControl(new mapboxgl.NavigationControl());

map.on("load", function () {

    //Stylization

    //Add pois layer to the map
    map.addSource("opentripmap.pois", {
        type: "vector",
        attribution:
            '<a href="https://opentripmap.io" target="_blank">© OpenTripMap</a>',
        bounds: [-180, -85.0511, 180, 85.0511],
        minzoom: 8,
        maxzoom: 14,
        scheme: "xyz",
        tiles: [
            "https://api.opentripmap.com/0.1/en/tiles/pois/{z}/{x}/{y}.pbf?kinds=museums&rate=3&apikey=5ae2e3f221c38a28845f05b63491fa7c34e2bf26d286b76a8e47f69d"
        ]
    });
    map.addLayer(
        {
            id: "opentripmap-pois",
            type: "circle",
            source: "opentripmap.pois",
            "source-layer": "pois",
            minzoom: 8,
            paint: {
                "circle-color": "rgb(55,144,144)",
                "circle-radius": 5,
                "circle-stroke-color": "rgba(102,193,201, 0.6)",
                "circle-stroke-width": 0.6
            }
        },
        "airport-label"
    );

    //Add heat layer to the map
    map.addSource("opentripmap.heat", {
        type: "vector",
        bounds: [-180, -85.0511, 180, 85.0511],
        minzoom: 1,
        maxzoom: 8,
        scheme: "xyz",
        tiles: [
            "https://api.opentripmap.com/0.1/en/tiles/heat/{z}/{x}/{y}.pbf?kinds=museums&rate=3&apikey=5ae2e3f221c38a28845f05b63491fa7c34e2bf26d286b76a8e47f69d"
        ]
    });
    map.addLayer(
        {
            id: "opentripmap-heat",
            type: "heatmap",
            source: "opentripmap.heat",
            "source-layer": "heat",
            minzoom: 1,
            maxzoom: 10,
            filter: ["all"],
            paint: {
                "heatmap-radius": {
                    stops: [
                        [1, 4],
                        [10, 20]
                    ]
                },
                "heatmap-weight": ["get", "n"],
                "heatmap-color": [
                    "interpolate",
                    ["linear"],
                    ["heatmap-density"],
                    0,
                    "rgba(236,222,239,0)",
                    0.1,
                    "rgb(210,180,160)",
                    0.2,
                    "rgb(255,221,149)",
                    0.6,
                    "rgb(253,104,96)"
                ],
                "heatmap-intensity": {
                    stops: [
                        [3, 0.1],
                        [8, 0.8]
                    ]
                },
                "heatmap-opacity": {
                    stops: [
                        [1, 0.9],
                        [8, 0.3]
                    ]
                }
            }
        },
        "opentripmap-pois"
    );

});

//Show information by click

function onShowPOI(data, lngLat) {
    let poi = document.createElement("div");
    poi.innerHTML = "<h2>" + data.name + "<h2>";
    poi.innerHTML += "<p><i>" + getCategoryName(data.kinds) + "</i></p>";
    if (data.preview) {
        poi.innerHTML += "<img class='map-img' src='"+data.preview.source+"'>";
    }
    poi.innerHTML += data.wikipedia_extracts
        ? data.wikipedia_extracts.html
        : data.info
            ? data.info.descr
            : "No description";

    poi.innerHTML += "<p><a target='_blank' href='"+ data.otm + "'>Show more at OpenTripMap</a></p>";

    new mapboxgl.Popup().setLngLat(lngLat)
        .setDOMContent(poi)
        .addTo(map);
}

map.on("click", "opentripmap-pois", function (e) {
    let coordinates = e.features[0].geometry.coordinates.slice();
    let id = e.features[0].properties.id;
    let name = e.features[0].properties.name;

    while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
        coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
    }
    apiGet("xid/" + id).then(data => onShowPOI(data, e.lngLat));

});

//Show popup by mousemove

let popup = new mapboxgl.Popup({
    closeButton: false,
    closeOnClick: false
});

map.on("mouseenter", "opentripmap-pois", function (e) {
    map.getCanvas().style.cursor = "pointer";

    let coordinates = e.features[0].geometry.coordinates.slice();
    let id = e.features[0].properties.id;
    let name = e.features[0].properties.name;

    while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
        coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
    }

    popup
        .setLngLat(coordinates)
        .setHTML("<strong>" + name + "</strong>")
        .addTo(map);
});

map.on("mouseleave", "opentripmap-pois", function () {
    map.getCanvas().style.cursor = "";
    popup.remove();
});