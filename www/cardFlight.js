
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

  CardFlight.prototype.configure = function(readerConnectedSuccess, readerConnectedError, 
    readerDisconnectedSuccess, readerDisconnectedError, 
    readerAttachedSuccess, readerAttachedError, 
    readerConnectingSuccess, readerConnectingError, options) {
    var successCallback = function() {
      console.log("SUCCESSFULLY SET TOKENS");
    }
    var errorCallback = function() {
      console.log("ERROR SETTING TOKENS");
    }
    this.startOnReaderAttached(readerAttachedSuccess, readerAttachedError);
    this.startOnReaderConnected(readerConnectedSuccess, readerConnectedError);
    this.startOnReaderDisconnected(readerDisconnectedSuccess, readerDisconnectedError);
    this.startOnReaderConnecting(readerConnectingSuccess, readerConnectingError);
    this.setApiTokens(successCallback, errorCallback, options);
  }

  CardFlight.prototype.initialize = function() {
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
