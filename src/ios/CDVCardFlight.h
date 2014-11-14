#import <Cordova/CDVPlugin.h>
#import "CardFlight.h"
#import "CFTSessionManager.h"
#import "CFTReader.h"
#import "CFTCard.h"
#import "CFTCharge.h"

@interface CDVCardFlight : CDVPlugin <CFTReaderDelegate>
{
    void (^readerDone)(void);
}

+ (NSString*)cordovaVersion;

- (void)setApiTokens:(CDVInvokedUrlCommand*)command;
- (void)swipeCard:(CDVInvokedUrlCommand*)command;
- (void)startOnReaderAttached:(CDVInvokedUrlCommand*)command;
- (void)startOnReaderDisconnected:(CDVInvokedUrlCommand*)command;
- (void)startOnReaderConnected:(CDVInvokedUrlCommand*)command;
- (void)startOnReaderConnecting:(CDVInvokedUrlCommand*)command;

@end
