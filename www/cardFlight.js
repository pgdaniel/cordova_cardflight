var argscheck = require('cordova/argscheck'),
  channel = require('cordova/channel'),
  utils = require('cordova/utils'),
  exec = require('cordova/exec'),
  cordova = require('cordova');

channel.createSticky('onCordovaCardFlightReady');
// Tell cordova channel to wait on the CordovaInfoReady event
channel.waitForInitialization('onCordovaCardFlightReady');

function CardFlight() {
    this.available = false;
    this.platform = null;
    this.cordova = null;
    this.config = null;

    var _this = this;

    channel.onCordovaReady.subscribe(function() {
      // ADD INITIALIZATION HERE
    });
}

CardFlight.prototype.configure = function(options) {
  var successCallback = function() {
    console.log("SUCCESSFULLY SET TOKENS");
  };
  var errorCallback = function() {
    console.log("ERROR SETTING TOKENS");
}
  this.setApiTokens(successCallback, errorCallback, options);
}


CardFlight.prototype.setApiTokens = function(successCallback, errorCallback, options) {
    exec(successCallback, errorCallback, "CDVCardFlight", "setApiTokens", [options.apiToken, options.accountToken]);
};

CardFlight.prototype.beginSwipe = function(successCallback, errorCallback) {
    exec(successCallback, errorCallback, "CDVCardFlight", "swipeCard", []);
};
               
module.exports = new CardFlight();
