/*
 *****************************************************************
 * CFTAPIResource.h
 *
 * Base class for handling communication with the CardFlight
 * servers. Is never instantiated directly.
 *
 * Copyright (c) 2013 CardFlight Inc. All rights reserved.
 *****************************************************************
 */

#import <Foundation/Foundation.h>
#import "CardFlight.h"

@interface CFTAPIResource : NSObject

@property (nonatomic, strong) CardFlight *cardflightDelegate;

/**
 * Constructor initializing with a CardFLight delegate to make callbacks
 * @param cardflightDelegate The CardFlight delegate
 */
- (id)initWithCardFlight:(CardFlight *)cardflight;

/**
 * Processes a POST Request to the CardFlight server
 * @param postSTring The string used to perform the post request.
 */
- (void)processPOSTRequest:(NSString *)postString;

/**
 * Process a generic request to the CardFlight server
 */
- (void)processRequestWithMethod:(NSString *)requestType
                      toEndpoint:(NSString *)endpoint
                  withParameters:(NSDictionary *)parameters
                         success:(void(^)(id response, id data))success
                         failure:(void(^)(id response, NSError *error))failure;

/**
 * Return the the Root API URL used within the application
 */
- (NSString *)getRootApiUrl;

@end
