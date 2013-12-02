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

/* @implementation UIDevice (ModelVersion) */
/*  */
/* - (NSString*)modelVersion */
/* { */
/*     NSString* platform = @"This is a test"; */
/*  */
/*     return platform; */
/* } */
/*  */
/* @end */

@interface CDVCardFlight () {}
@end

@implementation CDVCardFlight

- (void)getSerialNumber:(CDVInvokedUrlCommand*)command
{
    NSDictionary* deviceProperties = [self deviceProperties];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:deviceProperties];

    /* Settings.plist
     * Read the optional Settings.plist file and push these user-defined settings down into the web application.
     * This can be useful for supplying build-time configuration variables down to the app to change its behavior,
     * such as specifying Full / Lite version, or localization (English vs German, for instance).
     */
    // TODO: turn this into an iOS only plugin
    NSDictionary* temp = [CDVViewController getBundlePlist:@"Settings"];

    if ([temp respondsToSelector:@selector(JSONString)]) {
        NSLog(@"Deprecation warning: window.Setting will be removed Aug 2013. Refer to https://issues.apache.org/jira/browse/CB-2433");
        NSString* js = [NSString stringWithFormat:@"window.Settings = %@;", [temp JSONString]];
        [self.commandDelegate evalJs:js];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (NSDictionary*)deviceProperties
{
    UIDevice* device = [UIDevice currentDevice];
    NSMutableDictionary* devProps = [NSMutableDictionary dictionaryWithCapacity:4];

    [devProps setObject:@"Paul" forKey:@"model"];
    [devProps setObject:@"iOS" forKey:@"platform"];
    [devProps setObject:@"theVersion" forKey:@"version"];
    [devProps setObject:[device uniqueAppInstanceIdentifier] forKey:@"uuid"];
    [devProps setObject:[[self class] cordovaVersion] forKey:@"cordova"];

    NSDictionary* devReturn = [NSDictionary dictionaryWithDictionary:devProps];
    return devReturn;
}

+ (NSString*)cordovaVersion
{
    return CDV_VERSION;
}

@end
