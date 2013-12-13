cordova.define("org.apache.cordova.cardflight.cardFlight", function(require, exports, module) {var argscheck = require('cordova/argscheck'),
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

    var me = this;

    channel.onCordovaReady.subscribe(function() {
        me.setApiTokens(function(info) {
            //ignoring info.cordova returning from native, we should use value from cordova.version defined in cordova.js
            //TODO: CB-5105 native implementations should not return info.cordova
            var buildLabel = cordova.version;
            me.available = true;
            me.platform = info.platform;
            me.cordova = buildLabel;
            channel.onCordovaInfoReady.fire();
        },function(e) {
            me.available = false;
            utils.alert("[ERROR] Error initializing Cordova: " + e);
        });
    });
}

/**
 *
 * @param {Function} successCallback The function to call when the heading data is available
 * @param {Function} errorCallback The function to call when there is an error getting the heading data. (OPTIONAL)
 */
CardFlight.prototype.getSerialNumber = function(successCallback, errorCallback) {
    // argscheck.checkArgs('fF', 'CardFlight.getSerialNumber', arguments);
    exec(successCallback, errorCallback, "CDVCardFlight", "getSerial", []);
};
  
CardFlight.prototype.setApiTokens = function(successCallback, errorCallback) {
    // argscheck.checkArgs('fF', 'CardFlight.setApiTokens', arguments);
    exec(successCallback, errorCallback, "CDVCardFlight", "setApiTokens", [this.platform, "DEF"]);
};

CardFlight.prototype.swipeCard = function(successCallback, errorCallback) {
    // argscheck.checkArgs('fF', 'CardFlight.setApiTokens', arguments);
    exec(successCallback, errorCallback, "CDVCardFlight", "swipeCard", []);
};
               

               
module.exports = new CardFlight();
});
