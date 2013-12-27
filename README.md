# Usage

## Configuration

```javascript
cardFlight.configure(options)
```

### Example

```javascript
cardFlight.configure({
  apiToken: "<Card Flight API Token>",
  accountToken: "<Account Token>",
  tokenize: true
});
```

## Swipe card

```javascript
cardFlight.beginSwipe(func(<card>), func(<error>)[, options])
```

### Example

```javascript
var success = function (card) {
  console.log("swipe successful", card.token);
}

var error = function (error) {
  console.log("swipe error", error.message)
}

cardFlight.beginSwipe(success, error, { 
  swipeMessage: "Begin Swipe",
  cancelDialogButtonText: "Okay"
});
```

# Object Reference

### Card

```javascript
{
  token: "<token on merchant>"
}
```

### Error

```javascript
{
  message: "<some descriptive error message>",
  type: "<some type in Error.TYPES>"
}
```
