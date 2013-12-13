/*
 *****************************************************************
 * CFTReader.h
 *
 * Class to manage the hardware reader. Contains a protocol that
 * must be implemented by a delegate in order to process
 * responses from the hardware reader.
 *
 * An instance of CFTCard is returned after a successful swipe.
 *
 * Copyright (c) 2013 CardFlight Inc. All rights reserved.
 *****************************************************************
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CFTCard;

@protocol readerDelegate <NSObject>

@required

/**
 * Required protocol method that gets called when the hardware
 * reader has received a complete response. Returns a CFTCard object
 * with success and a NSError on failure.
 */
- (void)readerResponse:(CFTCard *)card withError:(NSError *)error;

@end

@interface CFTReader : NSObject

@property (nonatomic, weak) id<readerDelegate> delegate;

/**
 * Create a new CFTReader and have it attempt to connect to the 
 * hardware reader immediately.
 */
- (id)initAndConnect;

/**
 * Set the hardware reader to begin waiting to receive a swipe.
 * message sets an optional display message while the reader is waiting
 * to receive data.
 */
- (void)beginSwipeWithMessage:(NSString *)message;

/**
 * Manually attempt to the connection process with the hardware reader.
 */
- (void)connect;

/**
 * Manueally attempt to the disconnect process with the hardware reader.
 */
- (void)disconnect;

@end
