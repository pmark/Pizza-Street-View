/*
 *  AsyncArtworkFetcher.m
 *
 *  Created by Josh Aller on 12/29/09.
 *  Copyright 2010 Spot Metrix. All rights reserved.
 *
 *  see http://forums.macrumors.com/showthread.php?t=553870
 */

#import "AsyncArtworkFetcher.h"

@implementation AsyncArtworkFetcher

@synthesize delegate;
@synthesize receivedData;
@synthesize url;
@synthesize isFetching;
@synthesize connection;
@synthesize name;

- (id)init {

  if (self = [super init])
    self.isFetching = NO;

  return self;
}

- (UIImage*)fetch
{
  if ([[self.url absoluteString] length] == 0) 
    return nil;
    
  if (self.isFetching)
    return nil;

  NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:30.0];
  self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

  if (!self.connection)
    return nil;               // TODO: exception handling

  self.receivedData = [NSMutableData data];
  self.isFetching = YES;

  return nil;
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)response
{
  [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
  [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
  [self.connection release];
  self.isFetching = NO;
  UIImage *downloadedImage = [UIImage imageWithData:self.receivedData];

  if (self.delegate == nil) return;
  SEL delegateSelector = @selector(artworkFetcher:didFinish:);
  if ([self.delegate respondsToSelector:delegateSelector]) {
    [self.delegate performSelector:delegateSelector withObject:self withObject:downloadedImage];
  }
}

- (void) dealloc {

  if (self.isFetching) {
    NSLog (@"[AsyncArtworkFetcher] canceling fetch");
    [self.connection cancel];
    [self.connection release];
  }

  [name release];
  [delegate release];
  [receivedData release];
  [url release];
  [super dealloc];
}

@end

