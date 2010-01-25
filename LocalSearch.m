//
//  LocalSearch.m
//  SM3DARViewer
//
//  Created by P. Mark Anderson on 12/18/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import "LocalSearch.h"
#import "NSArray+BSJSONAdditions.h"
#import "NSString+BSJSONAdditions.h"
#import "UIApplication_TLCommon.h"

@implementation LocalSearch
@synthesize sm3dar, webData, query;

- (void)execute:(NSString*)searchQuery {
  self.query = searchQuery;
	CLLocation *loc = [self.sm3dar currentLocation];
  NSLog(@"Executing search for '%@' at current location: %@", searchQuery, loc);
  
	NSString *yahooMapUri = @"http://local.yahooapis.com/LocalSearchService/V3/localSearch?appid=YahooDemo&query=%@&latitude=%3.5f&longitude=%3.5f&results=20&output=json";
	NSString *uri = [NSString stringWithFormat:yahooMapUri, 
									 [searchQuery stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], loc.coordinate.latitude, loc.coordinate.longitude];
	NSLog(@"Searching...\n%@\n", uri);
	NSURL *mapSearchURL = [NSURL URLWithString:uri];
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:mapSearchURL] delegate:self startImmediately:YES];

	if (conn) {
    [[UIApplication sharedApplication] didStartNetworkRequest];
		self.webData = [NSMutableData data];
	} else {
		NSLog(@"ERROR: Connection was not established");
	}	
	[conn release];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[self.webData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  [[UIApplication sharedApplication] didStopNetworkRequest];
	NSLog(@"ERROR: Connection failed: %@", [error localizedDescription]);
}

// thank you http://json.parser.online.fr/
- (NSArray*)parseYahooMapSearchResults:(NSString*)json {
	NSDictionary *responseDict = [NSDictionary dictionaryWithJSONString:json];	
	NSDictionary *container = [responseDict objectForKey:@"ResultSet"];	
	NSArray *responseSet = [container objectForKey:@"Result"];
	NSDictionary *marker, *minMarker;
	NSMutableArray *markers = [NSMutableArray arrayWithCapacity:[responseSet count]];

	for (marker in responseSet) {
		minMarker = [NSDictionary dictionaryWithObjectsAndKeys:
							[marker objectForKey:@"Title"], @"title",
							[marker objectForKey:@"Address"], @"subtitle",
							[marker objectForKey:@"Latitude"], @"latitude",
							[marker objectForKey:@"Longitude"], @"longitude",
							self.query, @"search",
							nil];
		[markers addObject:minMarker];
	}
	
	return markers;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  [[UIApplication sharedApplication] didStopNetworkRequest];
	NSLog(@"Received bytes: %d", [self.webData length]);
	NSString *response = [[NSString alloc] initWithData:self.webData encoding:NSASCIIStringEncoding];
	//NSLog(@"RESPONSE:\n\n%@", response);	
	
	// convert response json into a collection of markers
	NSArray *markers = [self parseYahooMapSearchResults:response];
	
	NSLog(@"Adding %i POIs", [markers count]);
	if (markers && [markers count] > 0) {
    self.sm3dar.markerViewClass = nil;
		[self.sm3dar loadMarkersFromJSON:[markers jsonStringValue]];
	}
}

- (void)dealloc {
  [webData release];
	[sm3dar release];
  [query release];
	[super dealloc];
}


@end
