/*
 *  AsyncArtworkFetcher.h
 *
 *  Created by Josh Aller on 12/29/09.
 *  Copyright 2010 Spot Metrix. All rights reserved.
 *
 *  see http://forums.macrumors.com/showthread.php?t=553870
 */

#import <Foundation/Foundation.h>

@interface AsyncArtworkFetcher : NSObject
{
  NSObject *delegate;
  NSMutableData *receivedData;
  NSURL *url;
  BOOL isFetching;
  NSURLConnection *connection;
  NSString *name;
}

@property (nonatomic, retain) NSObject *delegate;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) BOOL isFetching;

- (UIImage*)fetch;

@end
