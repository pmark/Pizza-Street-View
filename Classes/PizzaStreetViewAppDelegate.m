//
//  PizzaStreetViewAppDelegate.m
//  PizzaStreetView
//
//  Created by P. Mark Anderson on 1/24/10.
//  Copyright Bordertown Labs, LLC 2010. All rights reserved.
//

#import "PizzaStreetViewAppDelegate.h"
#import "PizzaStreetViewViewController.h"

@implementation PizzaStreetViewAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
  [[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];    
  
  // Override point for customization after app launch    
  [window addSubview:viewController.view];
  [window makeKeyAndVisible];
}


- (void)dealloc {
  [viewController release];
  [window release];
  [super dealloc];
}


@end
