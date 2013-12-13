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
@end

@implementation CDVCardFlight


- (void)setApiTokens:(CDVInvokedUrlCommand*)command {
    [[CardFlight sharedInstance] setApiToken:@"4fb831302debeb03128c5c23633a5b42" accountToken:@"c10aa9a847b55d87"];
     //NSString* myarg = [command.arguments objectAtIndex:0];
     NSLog(@"SET API");
     NSLog(@"%@", [[CardFlight sharedInstance] getApiToken]);
    
    _reader = [[CFTReader alloc] initAndConnect];
    [_reader setDelegate:self];
}

/* - (void)getSerial:(CDVInvokedUrlCommand*)command { */
/*    // NSString *serialNumber = [[CardFlight sharedInstance] getReaderSerialNumber]; */
/*     //NSLog(@"GET SERIAL %@", serialNumber); */
/* } */


- (void)swipeCard:(CDVInvokedUrlCommand*)command {
    [_reader beginSwipeWithMessage:@"Swipe Card"];
}

#pragma mark - CardFlight Delegate


- (void)readerResponse:(CFTCard *)card withError:(NSError *)error {
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CardFlight"
                                                        message:error.localizedDescription
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        _card = card;
//        [_nameTextField setText:card.name];
//        [_customView.cardNumber customFieldText:card.encryptedCardNumber];
//        [_customView.expirationDate customFieldText:[NSString stringWithFormat:@"%i/%i", card.expirationMonth, card.expirationYear]];
        NSLog(@"IN RESPONSE");
    }
}


//Response after manual entry
-(void)manualEntryDictionary:(NSDictionary *)dictionary
{
    //nameTextField.text = [dictionary objectForKey:@"name"];
    //numberTextField.text = [dictionary objectForKey:@"number"];
    //expDateTextField.text = [NSString stringWithFormat:@"%@/%@", [dictionary objectForKey:@"expiration month"], [dictionary objectForKey:@"expiration year"]];
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
