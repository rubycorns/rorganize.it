var ZoomLevel = 13

$(function() {
  var container = document.getElementById('map');
  if (!container) return;
  var group = container.dataset;
  if (group.latitude == null || group.longitude == null) return;
  var map = L.map('map', {scrollWheelZoom:false}).setView([group.latitude, group.longitude], ZoomLevel);
  var marker = L.marker([group.latitude, group.longitude]).addTo(map);
  L.tileLayer('//{s}.tile.openstreetmap.se/hydda/full/{z}/{x}/{y}.png', {
    container_id: "group-map",
    center: {
      latlng: [group.latitude, group.longitude],
      zoom: 16
    },
    attribution: 'Map data &copy; <a href="//openstreetmap.org" target="_blank">OpenStreetMap contributors</a>,<a href="https://creativecommons.org/licenses/by-sa/2.0/" target="_blank">CC-BY-SA</a>' 
  }).addTo(map);
});