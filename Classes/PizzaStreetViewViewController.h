//
//  PizzaStreetViewViewController.h
//  PizzaStreetView
//
//  Created by P. Mark Anderson on 1/24/10.
//  Copyright Spot Metrix 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SM3DAR.h"
#import "LocalSearch.h"

@interface PizzaStreetViewViewController : UIViewController <SM3DAR_Delegate, UIActionSheetDelegate> {
  LocalSearch *search;
  SM3DAR_PointOfInterest *selectedPOI;
}

@property (nonatomic, retain) LocalSearch *search;
@property (nonatomic, retain) SM3DAR_PointOfInterest *selectedPOI;

@end

