//
//  CFTBaseReader.h
//  CardFlightLibrary
//
//  Created by Paul Tower on 6/10/14.
//  Copyright (c) 2014 CardFlight Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CFTCard;

@protocol CFTReaderDelegate <NSObject>

@required

/**
 * Required protocol method that gets called when the hardware
 * reader has received a complete swipe. Returns a CFTCard object
 * with success and a NSError on failure.
 */
- (void)readerCardResponse:(CFTCard *)card withError:(NSError *)error;

@optional

/**
 * Optional protocol method that gets called after the hardware
 * reader is physically attached.
 */
- (void)readerIsAttached;

/**
 * Optional protocol method that gets called after a hardware
 * reader begins the connection process.
 */
- (void)readerIsConnecting;

/**
 * Optional protocol method that gets called after an attempt is made
 * to connect with the hardware reader. If isConnected is FALSE then
 * the NSError object will contain the description.
 */
- (void)readerIsConnected:(BOOL)isConnected withError:(NSError *)error;

/**
 * Optional protocol method that gets called in a non credit card is
 * swiped. The raw data from swipe is passed without any processing.
 */
- (void)readerGenericResponse:(NSString *)cardData;

/**
 * Optional protocol method that gets called after the hardware reader
 * is disconnected and physically detached.
 */
- (void)readerIsDisconnected;

/**
 * Optional protocol method that gets called after the serial number
 * of the hardware reader has been retrieved.
 */
- (void)readerSerialNumber:(NSString *)serialNumber;

/**
 * Optional protocol method that gets called after the user cancels
 * a swipe.
 */
- (void)readerSwipeDidCancel;

@end

@interface CFTBaseReader : NSObject

@property (nonatomic, weak) id<CFTReaderDelegate> delegate;

/**
 * Create a new CFTReader and have it attempt to connect to the
 * hardware reader immediately.
 */
- (id)initAndConnect;

@end
