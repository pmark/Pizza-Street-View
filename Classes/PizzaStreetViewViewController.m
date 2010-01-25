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
@synthesize search, selectedPOI;

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


- (void) didChangeFocusToPOI:(SM3DAR_Point*)newPOI fromPOI:(SM3DAR_Point*)oldPOI {
}

- (void) phoneAction {
  NSString *phone = [selectedPOI.properties objectForKey:@"Phone"];
  NSMutableString *str = [NSMutableString string];
  
  for (int i=0; i < [phone length]; i++) {
    if (isdigit([phone characterAtIndex:i])) {
      [str appendFormat:@"%c", [phone characterAtIndex:i]];
    }
  }
  
  phone = [NSString stringWithFormat:@"tel://1-%@", str];
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}

- (void) webAction {
//  NSString *urlBiz = [selectedPOI.properties objectForKey:@"BusinessClickUrl"];
  NSString *urlYahoo = [selectedPOI.properties objectForKey:@"ClickUrl"];
  
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlYahoo]];
}

- (void) mapAction {
  CLLocation *loc = [SM3DAR_Controller sharedSM3DAR_Controller].currentLocation;
  NSString *address = [selectedPOI.properties objectForKey:@"Address"];
  NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%f,%f&daddr=%@",
                   loc.coordinate.latitude, loc.coordinate.longitude,
                   [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void) showActionSheet {
  NSString *title = [NSString stringWithFormat:@"%@\n%@\n%@",
                     [selectedPOI.properties objectForKey:@"title"], 
                     [selectedPOI.properties objectForKey:@"Address"], 
                     [selectedPOI.properties objectForKey:@"Phone"]];

  UIActionSheet *actionSheet = [[UIActionSheet alloc]
                     initWithTitle:title
                     delegate:self
                     cancelButtonTitle:@"Cancel"
                     destructiveButtonTitle:nil
                     otherButtonTitles:@"Phone", @"Web", @"Map", nil];
  
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	//NSInteger cancelIndex = actionSheet.cancelButtonIndex;

  switch (buttonIndex) {
    case 0:
      // phone
      [self phoneAction];
      break;
    case 1:
      [self webAction];
      break;
    case 2:
      [self mapAction];
      break;
    default:
      break;
  }
}

- (void) didChangeSelectionToPOI:(SM3DAR_Point*)newPOI fromPOI:(SM3DAR_Point*)oldPOI {
  if ([newPOI isKindOfClass:[SM3DAR_PointOfInterest class]]) {
    self.selectedPOI = (SM3DAR_PointOfInterest*)newPOI;
    [self showActionSheet];
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
  [selectedPOI release];
  [super dealloc];
}

@end
