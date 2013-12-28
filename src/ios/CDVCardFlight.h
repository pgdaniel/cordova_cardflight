#import <Cordova/CDVPlugin.h>
#import "CardFlight.h"
#import "CFTReader.h"
#import "CFTCard.h"
#import "CFTCharge.h"

@interface CDVCardFlight : CDVPlugin <readerDelegate>
{
    void (^readerDone)(void);
}

+ (NSString*)cordovaVersion;

- (void)setApiTokens:(CDVInvokedUrlCommand*)command;
- (void)swipeCard:(CDVInvokedUrlCommand*)command;

@end
