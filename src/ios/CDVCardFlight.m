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
    [[CardFlight sharedInstance] setApiToken:@"1234" accountToken:@"5678"];
     /* NSString* apiToken = [command.arguments objectAtIndex:0]; */
     NSLog(@"SET API");
     NSLog(@"%@", [[CardFlight sharedInstance] getApiToken]);
     /* NSLog(@"API TOKEN %@\n", apiToken); */
    
    _reader = [[CFTReader alloc] initAndConnect];
    [_reader setDelegate:self];
}


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
        NSLog(@"IN RESPONSE %@", _card.name);
        [_card tokenizeCardWithSuccess:^{
            NSLog(@"Card Token:  %@\n", _card.cardToken);
                       }
                       failure:^(NSError *error){
                 NSLog(@"ERROR:", error.code);
                       }];
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
