//
//  TestFoursquareAPIViewController.m
//  TestFoursquareAPI
//
//  Created by Fernando Moribe on 3/22/13.
//  Copyright (c) 2013 Fernando Moribe. All rights reserved.
//

#import "TestFoursquareAPIViewController.h"
#import "AFNetworking.h"
#import "NSDictionary+venue.h"


NSString *const BaseURLString = @"https://api.foursquare.com/v2/venues/search?";



@interface TestFoursquareAPIViewController ()

@property (strong) NSString *client_id;
@property (strong) NSString *client_secret;
@property (strong) CLLocationManager *cllManager;
@property (strong) NSDictionary *venues;
@property (strong) NSArray *venuesArray;

@end





@implementation TestFoursquareAPIViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self readFoursquareClientAndSecret];

    self.cllManager = [[CLLocationManager alloc] init];
    self.cllManager.delegate = self;
    
    //Start get the user location
    [self startFindLocation];
    
    

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)readFoursquareClientAndSecret {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"foursquare" ofType:@"plist"];
    NSDictionary *dictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    self.client_id = [dictionary objectForKey:@"client_id"];
    self.client_secret =[dictionary objectForKey:@"client_secret"];
}



-(void)startFindLocation
{
    [self.cllManager startUpdatingLocation];
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.cllManager stopUpdatingLocation];
    CLLocation *actualLocation = [locations lastObject];
    
    
    [self refreshByLocation:actualLocation];
    
}



-(void)refreshByLocation:(CLLocation *)location
{
    
    NSMutableString *title = [@"At " mutableCopy];
    [title appendString:[[NSNumber numberWithDouble:location.coordinate.latitude] stringValue]];
    [title appendString:@", "];
    [title appendString:[[NSNumber numberWithDouble:location.coordinate.longitude] stringValue]];
    
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    
    
    NSMutableString *foursquareURL = [BaseURLString mutableCopy];
    [foursquareURL appendString:@"client_id="];
    [foursquareURL appendString:self.client_id];
    [foursquareURL appendString:@"&client_secret="];
    [foursquareURL appendString:self.client_secret];
    [foursquareURL appendString:@"&limit=50&intent=browse&radius=800&ll="];
    [foursquareURL appendString:[[NSNumber numberWithDouble:location.coordinate.latitude] stringValue]];
    [foursquareURL appendString:@","];
    [foursquareURL appendString:[[NSNumber numberWithDouble:location.coordinate.longitude] stringValue]];
    [foursquareURL appendString:@"&v="];
    [foursquareURL appendString:[dateFormat stringFromDate:date]];
    
    NSLog(@"URL: %@", foursquareURL);
    
    
    NSURL *url = [NSURL URLWithString:foursquareURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest: request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        self.venues  = (NSDictionary *)JSON;
                                                        self.venuesArray = [self.venues closestVenues];
                                                        self.title = title;
                                                        [self.tableView reloadData];
                                                        
                                                    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                                                     message:[NSString stringWithFormat:@"%@",error]
                                                                                                    delegate:nil
                                                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                        [av show];
                                                    }];
    
    
    
    [operation start];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.venuesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [[self.venuesArray objectAtIndex:indexPath.row] venueDescription];
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
