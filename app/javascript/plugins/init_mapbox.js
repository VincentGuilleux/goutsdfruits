import mapboxgl from 'mapbox-gl';

// DON'T FORGET TO ADD THIS LINE IN THE <head> IN app/views/application.html.erb
// <%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>

import "mapbox-gl/dist/mapbox-gl.css";

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    // initialize map
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10',
      center: [-0.672743, 46.843101],
      zoom: 9,
    });
    // on ajoute le marker pour l'Orgerie
    const marker = new mapboxgl.Marker()
      .setLngLat([-0.672743, 46.843101]) // base
      .addTo(map); // base
  }

};

export { initMapbox };
