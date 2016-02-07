var args = require('system').args;
var url = args[1];
var filename = args[2];

var Screenshot = function(url, filename) {
  this.url = url;
  this.filename = filename;
}

Screenshot.prototype.grab = function() {                    // Phantomjs grabs screenshot
  var page = require('webpage').create();
  page.viewportSize = { width: 512, height: 384 };               // Previously 1024 x 768
  // page.zoomFactor = 0.25;
  page.clipRect = { top: 0, left: 0, width: 384, height: 288 };  // Previously 576 x 432
  page.open(this.url, function() {
    page.render(filename, {format: 'jpg', quality: '20'});       // Saves to Tempfile
    phantom.exit();
  });
}

getit = new Screenshot(url);
getit.grab();