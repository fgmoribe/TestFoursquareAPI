//
//  NSDictionary+venue.m
//  TestFoursquareAPI
//
//  Created by Fernando Moribe on 3/28/13.
//  Copyright (c) 2013 Fernando Moribe. All rights reserved.
//

#import "NSDictionary+venue.h"

@implementation NSDictionary (venue)



-(NSArray *)closestVenues
{
    NSDictionary *dictResponse = [self objectForKey:@"response"];
    return [dictResponse objectForKey:@"venues"];
}



-(NSString *)venueDescription
{
    NSString *description = [self objectForKey:@"name"];
    return description;
}

@end
