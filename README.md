# Cordova plugin for CardFlight

cordova-plugin-card-flight
-----------------------
To install this plugin, follow the [Command-line Interface Guide](http://cordova.apache.org/docs/en/edge/guide_cli_index.md.html#The%20Command-line%20Interface).

If you are not using the Cordova Command-line Interface, follow [Using Plugman to Manage Plugins](http://cordova.apache.org/docs/en/edge/plugin_ref_plugman.md.html).

## Setup

1. Add the CardFlight cordova plugin to your project: 

	`cordova plugin add <path-to-plugin>/cordova-plugin-cardflight`
	

## Using the plugin



1. Setup the tokens

* ```tokenize``` will return a card tokenized with payment processor for storing locally

```

cardFlight.config = {
  apiToken:"<Card Flight API Token>",
  accountToken:"<Account Token>"
  tokenize: true
}

cardFlight.setTokens();
```

* On success returns TBD

1. Initialize the reader

```

messages = {
  swipeMessage:"Begin Swipe",
  cancelDialogButtonText:"Okay"
}

cardFlight.beginSwipe(messages);
```
* Returns a card

### Behavior
* Pops up a dialog with the string of the variable message.
* If the reader gets a successful swipe the dialog disappears. 
* After 20 seconds the dialog will time out with the error dialog.
* NOTE: This UI functionality is build into the CardFlight obj-c library





