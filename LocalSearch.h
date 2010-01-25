//
//  LocalSearch.h
//  SM3DARViewer
//
//  Created by P. Mark Anderson on 12/18/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SM3DAR.h"

@interface LocalSearch : NSObject {
  SM3DAR_Controller* sm3dar;
	NSMutableData *webData;
  NSString *query;
}

@property (nonatomic, retain) NSMutableData *webData;
@property (nonatomic, retain) SM3DAR_Controller *sm3dar;
@property (nonatomic, retain) NSString *query;

- (void)execute:(NSString*)searchQuery;

@end
