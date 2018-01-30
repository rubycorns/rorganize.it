$(function() {
  var zoomLevel = 2;
  var coord = [20.0, 0.0];
  var container = document.querySelector('.index-map');
  if (!container) return;

  var map = L.map('map', { scrollWheelZoom:false }).setView(coord, zoomLevel);

  L.tileLayer('//a.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    container_id: "map",
    center: {
      latlng: coord,
      zoom: zoomLevel
    },
    attribution: 'Map data &copy; <a href="//openstreetmap.org" target="_blank">OpenStreetMap contributors</a>,<a href="https://creativecommons.org/licenses/by-sa/2.0/" target="_blank">CC-BY-SA</a>'
  }).addTo(map);

  var groupCoords = document.querySelectorAll('.index-map ul li');

  groupCoords.forEach(function(i) {
    var lat = i.getAttribute('data-lat');
    var long = i.getAttribute('data-long');
    if (lat !== null && long !== null) {
      L.marker([lat, long]).addTo(map);
    }
  });
});
