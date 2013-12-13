  var argscheck = require('cordova/argscheck'),
    channel = require('cordova/channel'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec'),
    cordova = require('cordova');

channel.createSticky('onCordovaInfoReady');
// Tell cordova channel to wait on the CordovaInfoReady event
channel.waitForInitialization('onCordovaInfoReady');

function CardFlight() {
    this.available = false;
    this.platform = null;
    this.cordova = null;
    this.config = null;

    var _this = this;

    channel.onCordovaReady.subscribe(function() {
        _this.setApiTokens(function(config) {
            var buildLabel = cordova.version;
            _this.available = true;
            _this.platform = info.platform;
            _this.cordova = buildLabel;
            channel.onCordovaInfoReady.fire();
        },function(e) {
            _this.available = false;
            utils.alert("[ERROR] Error initializing Cordova: " + e);
        });
    });
}

CardFlight.prototype.setApiTokens = function(config) {
    exec(successCallback, errorCallback, "CDVCardFlight", "setApiTokens", [config.apiToken, config.accountToken]);
};

CardFlight.prototype.swipeCard = function(successCallback, errorCallback) {
    exec(successCallback, errorCallback, "CDVCardFlight", "swipeCard", []);
};
               
               
module.exports = new CardFlight();
