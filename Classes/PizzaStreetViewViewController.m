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
