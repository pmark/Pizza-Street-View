//
//  PizzaStreetViewAppDelegate.h
//  PizzaStreetView
//
//  Created by P. Mark Anderson on 1/24/10.
//  Copyright Bordertown Labs, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PizzaStreetViewViewController;

@interface PizzaStreetViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PizzaStreetViewViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PizzaStreetViewViewController *viewController;

@end

