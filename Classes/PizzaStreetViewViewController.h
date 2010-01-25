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
#import "AudioToolbox/AudioServices.h"

@interface PizzaStreetViewViewController : UIViewController <SM3DAR_Delegate, UIActionSheetDelegate, CLLocationManagerDelegate> {
  LocalSearch *search;
  SM3DAR_PointOfInterest *selectedPOI;
	SystemSoundID focusSound;
  NSDate *lastLocationUpdate;
}

@property (nonatomic, retain) LocalSearch *search;
@property (nonatomic, retain) SM3DAR_PointOfInterest *selectedPOI;

- (void)initSound;
- (void)playFocusSound;

@end

