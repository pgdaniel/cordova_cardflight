var argscheck = require('cordova/argscheck'),
  channel = require('cordova/channel'),
  utils = require('cordova/utils'),
  exec = require('cordova/exec'),
  cordova = require('cordova');

channel.createSticky('onCordovaCardFlightReady');
channel.waitForInitialization('onCordovaCardFlightReady');

function CardFlight() {
    this.available = false;
    this.platform = null;
    this.cordova = null;
    this.config = null;

    var _this = this;

    channel.onCordovaReady.subscribe(function() {
      _this.initialize();
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

CardFlight.prototype.initialize = function() {

  var successCallback = function() {
    console.log("startOnReaderAttached Successful");
  };
  var errorCallback = function() {
    console.log("startOnReaderAttached failure");
  }
  this.startOnReaderAttached(successCallback, errorCallback);
  this.startOnReaderConnected(successCallback, errorCallback);
  this.startOnReaderDisconnected(successCallback, errorCallback);
  this.startOnReaderConnecting(successCallback, errorCallback);

  channel.onCordovaCardFlightReady.fire();
}


CardFlight.prototype.setApiTokens = function(successCallback, errorCallback, options) {
    exec(successCallback, errorCallback, "CDVCardFlight", "setApiTokens", [options.apiToken, options.accountToken]);
};

CardFlight.prototype.beginSwipe = function(successCallback, errorCallback) {
    exec(successCallback, errorCallback, "CDVCardFlight", "swipeCard", []);
};

CardFlight.prototype.startOnReaderAttached = function(successCallback, errorCallback) {
    exec(successCallback, errorCallback, "CDVCardFlight", "startOnReaderAttached", []);
};

CardFlight.prototype.startOnReaderConnected = function(successCallback, errorCallback) {
    exec(successCallback, errorCallback, "CDVCardFlight", "startOnReaderConnected", []);
};

CardFlight.prototype.startOnReaderDisconnected = function(successCallback, errorCallback) {
    exec(successCallback, errorCallback, "CDVCardFlight", "startOnReaderDisconnected", []);
};

CardFlight.prototype.startOnReaderConnecting = function(successCallback, errorCallback) {
    exec(successCallback, errorCallback, "CDVCardFlight", "startOnReaderConnecting", []);
};
               
module.exports = new CardFlight();
