//
//  PizzaStreetViewViewController.m
//  PizzaStreetView
//
//  Created by P. Mark Anderson on 1/24/10.
//  Copyright Bordertown Labs, LLC 2010. All rights reserved.
//

#import "PizzaStreetViewViewController.h"
#import "SphereView.h"
#import "AnimatedSphereView.h"
#import "LocalSearch.h"


#define STREET_VIEW_URL_FORMAT @"http://maps.google.com/cbk?output=thumbnail&ll=%f,%f"

@implementation PizzaStreetViewViewController
@synthesize search;

#pragma mark -
- (void)viewDidLoad {
  [super viewDidLoad];
  
  SM3DAR_Controller *sm3dar = [SM3DAR_Controller sharedSM3DAR_Controller];
  sm3dar.delegate = self;
  [self.view addSubview:sm3dar.view];  
}

-(void)loadPointsOfInterest {
  SM3DAR_Controller *sm3dar = [SM3DAR_Controller sharedSM3DAR_Controller];

  sm3dar.view.backgroundColor = [UIColor blackColor];
  
  self.search = [[[LocalSearch alloc] init] autorelease];
  search.sm3dar = sm3dar;
  [search execute:@"pizza"];

  SM3DAR_Fixture *fixture = [[SM3DAR_Fixture alloc] init];  
  CLLocation *loc = [sm3dar currentLocation];
  NSString *urlString = [NSString stringWithFormat:STREET_VIEW_URL_FORMAT, 
                         loc.coordinate.latitude, loc.coordinate.longitude];
  NSURL *url = [NSURL URLWithString:urlString];
  
  SphereView *sv = [[[SphereView alloc] initWithTextureURL:url] autorelease];
//  SphereView *sv = [[[SphereView alloc] initWithTextureNamed:@"texture.png"] autorelease];
  fixture.view = sv;
  
  [sm3dar addPointOfInterest:fixture];
}


-(void)didChangeFocusToPOI:(SM3DAR_Point*)newPOI fromPOI:(SM3DAR_Point*)oldPOI {
}

-(void)didChangeSelectionToPOI:(SM3DAR_Point*)newPOI fromPOI:(SM3DAR_Point*)oldPOI {
  NSLog(@"calling");
  if ([newPOI isKindOfClass:[SM3DAR_PointOfInterest class]]) {
    SM3DAR_PointOfInterest *poi = (SM3DAR_PointOfInterest*)newPOI;
    NSLog(@"props: %@", poi.properties);
    NSString *urlBiz = [poi.properties objectForKey:@"BusinessClickUrl"];
    NSString *urlYahoo = [poi.properties objectForKey:@"ClickUrl"];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1-805-689-5074"]];
  }
}


 
#pragma mark -
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
  [search release];
  [super dealloc];
}

@end
