//
//  NSDictionary+venue.h
//  TestFoursquareAPI
//
//  Created by Fernando Moribe on 3/28/13.
//  Copyright (c) 2013 Fernando Moribe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (venue)

-(NSArray *)closestVenues;
-(NSString *)venueDescription;

@end
