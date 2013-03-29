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
 
    NSLog(@"=================== CHAMADA DE CLOSESTVENUES===================");
    NSDictionary *meta = [self objectForKey:@"meta"];
    NSString *code = [meta objectForKey:@"code"];
    NSLog(@"code: %@", code);
          
          
    NSDictionary *dictResponse = [self objectForKey:@"response"];
    return [dictResponse objectForKey:@"venues"];
    
}



-(NSString *)venueDescription
{
    NSString *description = [self objectForKey:@"name"];
    return description;
}

@end
