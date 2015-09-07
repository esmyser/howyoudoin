function initialize() {
  var happyGradient = [
    'rgba(0, 255, 255, 0)',
    'rgba(0, 255, 255, 1)',
    'rgba(0, 225, 255, 1)',
    'rgba(0, 200, 255, 1)',
    'rgba(0, 175, 255, 1)',
    'rgba(0, 160, 255, 1)',
    'rgba(0, 145, 223, 1)',
    'rgba(0, 125, 191, 1)',
    'rgba(0, 110, 255, 1)',
    'rgba(0, 100, 255, 1)',
    'rgba(0, 75, 255, 1)',
    'rgba(0, 50, 255, 1)',
    'rgba(0, 25, 255, 1)',
    'rgba(0, 0, 255, 1)'
    ]

  var angryGradient = [
    'rgba(255, 255, 0, 0)',
    'rgba(255, 255, 0, 1)',
    'rgba(255, 225, 0, 1)',
    'rgba(255, 200, 0, 1)',
    'rgba(255, 175, 0, 1)',
    'rgba(255, 160, 0, 1)',
    'rgba(255, 145, 0, 1)',
    'rgba(255, 125, 0, 1)',
    'rgba(255, 110, 0, 1)',
    'rgba(255, 100, 0, 1)',
    'rgba(255, 75, 0, 1)',
    'rgba(255, 50, 0, 1)',
    'rgba(255, 25, 0, 1)',
    'rgba(255, 0, 0, 1)'
  ]

  map = new Map;
  heatMap(map.map, gon.happyTweets, happyGradient);
  heatMap(map.map, gon.angryTweets, angryGradient);


  // $("#slider").slider({
  //   value: 12,
  //   min: 0,
  //   max: 23,
  //   step: 0.1,
  //   slide: function(event, ui) {
  //     if (parseInt($("#hour").val()) !== Math.round(ui.value)) {
  //       setHour(ui.value);
  //     }
  //   }
  // });

  // $("#hour").val($("#slider").slider("value") + ':00');
}

function Map() {
  var styling = [{"featureType":"water","elementType":"geometry","stylers":[{"color":"#e9e9e9"},{"lightness":17}]},{"featureType":"landscape","elementType":"geometry","stylers":[{"color":"#f5f5f5"},{"lightness":20}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#ffffff"},{"lightness":17}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#ffffff"},{"lightness":29},{"weight":0.2}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#ffffff"},{"lightness":18}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#ffffff"},{"lightness":16}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#f5f5f5"},{"lightness":21}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#dedede"},{"lightness":21}]},{"elementType":"labels.text.stroke","stylers":[{"visibility":"on"},{"color":"#ffffff"},{"lightness":16}]},{"elementType":"labels.text.fill","stylers":[{"saturation":36},{"color":"#333333"},{"lightness":40}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#f2f2f2"},{"lightness":19}]},{"featureType":"administrative","elementType":"geometry.fill","stylers":[{"color":"#fefefe"},{"lightness":20}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#fefefe"},{"lightness":17},{"weight":1.2}]}]
  var mapCanvas = document.getElementById('map-canvas');
  var mapOptions = {
    zoom: 12,
    streetViewControl: false, 
    draggable: true, 
    scrollwheel: false,
    panControl: true, 
    styles: styling,
    mapTypeControl: false,
    center: new google.maps.LatLng(40.7731295,-73.957734),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  this.map = new google.maps.Map(mapCanvas, mapOptions);
}

function heatMap(map, tweets, gradient) {
  var data = []

  for (var i = 0; i < tweets.length; i++){
      data.push(new google.maps.LatLng(tweets[i].lng, tweets[i].lat));
    }

  pointArray = new google.maps.MVCArray(data);
  
  heatmap = new google.maps.visualization.HeatmapLayer({
      data: pointArray,
      opacity: .9,
      radius: 25,
    });

  heatmap.set('gradient', gradient);

  heatmap.setMap(map);
}

google.maps.event.addDomListener(window, 'load', initialize);


// function toggleHeatmap() {
//   heatmap.setMap(heatmap.getMap() ? null : map);
// }

// function setHour(hour) {
//   var tmpHeatMap = heatmap;

//   hour = Math.round(hour);

//   $("#hour").val(hour + ":00");

//   setTimeout(function(){tmpHeatMap.setMap(null);}, 80);
// }