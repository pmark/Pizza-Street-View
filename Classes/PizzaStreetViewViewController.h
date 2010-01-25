//
//  PizzaStreetViewViewController.h
//  PizzaStreetView
//
//  Created by P. Mark Anderson on 1/24/10.
//  Copyright Bordertown Labs, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SM3DAR.h"
#import "LocalSearch.h"

@interface PizzaStreetViewViewController : UIViewController <SM3DAR_Delegate> {
  LocalSearch *search;
}

@property (nonatomic, retain) LocalSearch *search;

@end

