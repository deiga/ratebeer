# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  initialize = () ->
    myLatlng = new google.maps.LatLng(window.lat, window.lon);
    mapOptions = {
      zoom: 16,
      center: myLatlng
    }
    map = new google.maps.Map(document.getElementById('map'), mapOptions)

    marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: window.place_name
  })

  google.maps.event.addDomListener(window, 'load', initialize)
