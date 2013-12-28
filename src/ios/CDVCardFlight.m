/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import <Cordova/CDV.h>
#import "CDVCardFlight.h"

@interface CDVCardFlight ()
@property (nonatomic) CFTReader *reader;
@property (nonatomic) CFTCard *card;
@property (nonatomic) CDVPluginResult *readerPluginResult;
@end

@implementation CDVCardFlight

- (void)setApiTokens:(CDVInvokedUrlCommand*)command {
    NSString* apiToken = [command.arguments objectAtIndex:0];
    NSString* accountToken = [command.arguments objectAtIndex:1];
    CDVPluginResult* pluginResult = nil;

    [[CardFlight sharedInstance] setApiToken:apiToken accountToken:accountToken];

    NSLog(@"API TOKEN: %@ ACCOUNT TOKEN: %@\n", [[CardFlight sharedInstance] getApiToken], [[CardFlight sharedInstance] getAccountToken]);
    
    _reader = [[CFTReader alloc] initAndConnect];
    if (_reader) {
      [_reader setDelegate:self];
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (void)swipeCard:(CDVInvokedUrlCommand*)command {
    [_reader beginSwipeWithMessage:@"Swipe Card"];
    
    // Here wait for the cardResponse to complete via block
    
    __weak CDVCardFlight *weakSelf = self;
    readerDone = ^{
        [weakSelf.commandDelegate sendPluginResult:weakSelf.readerPluginResult
                                        callbackId:command.callbackId];
        NSLog(@"READER DONE");
        NSLog(@"READER CALLBACKID %@\n", command.callbackId);
        NSLog(@"READER RESULT %@\n", weakSelf.readerPluginResult);
    };
  weakSelf = nil;
}

- (void)readerCardResponse:(CFTCard *)card withError:(NSError *)error {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CardFlight" message:error.localizedDescription delegate:self 
                                              cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else {
        _card = card;
        NSLog(@"IN RESPONSE %@", _card.name);
        [_card tokenizeCardWithSuccess:^{
            NSLog(@"Card Token:  %@\n", _card.cardToken);
            _readerPluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                    messageAsDictionary:@{@"cardToken": _card.cardToken}];
              // Callback to the block in the swipeCard method
              readerDone();
         }
                       failure:^(NSError *error){
                           NSLog(@"ERROR CODE: %i", error.code);
                           _readerPluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                                   messageAsString:error.localizedDescription];
                          // Callback to the block in the swipeCard method
                          readerDone();
                       }];
    }
}


//Response after manual entry
-(void)manualEntryDictionary:(NSDictionary *)dictionary
{
}


//Server response after submitting data
-(void)serverResponse:(NSData *)response andError:(NSError *)error
{
    //Manage the CardFlight API server response
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"Server Response: %@", jsonDict);
}


+ (NSString*)cordovaVersion
{
    return CDV_VERSION;
}
@end

