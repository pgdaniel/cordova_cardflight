
#import <Cordova/CDVPlugin.h>
#import "CardFlight.h"
#import "CFTReader.h"
#import "CFTCard.h"

@interface CDVCardFlight : CDVPlugin <readerDelegate>
{}

+ (NSString*)cordovaVersion;

- (void)setApiTokens:(CDVInvokedUrlCommand*)command;
- (void)swipeCard:(CDVInvokedUrlCommand*)command;
// - (void)getSerial:(CDVInvokedUrlCommand*)command;

@end
