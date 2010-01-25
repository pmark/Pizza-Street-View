//
//  Star3DMarkerView.m
//  SM3DARViewer
//
//  Created by Josh Aller 1/21/10.
//  Copyright 2010 Spot Metrix, Inc. All rights reserved.
//

#import "SphereView.h"
#import <OpenGLES/ES1/gl.h>

@implementation SphereView

@synthesize zrot, color, geometry, texture, textureName, textureURL, artworkFetcher, textureImage;

- (id) initWithTextureNamed:(NSString*)name {
  self.textureName = name;
  if (self = [super initWithFrame:CGRectZero]) {    
  }
  return self;
}

- (id) initWithTextureURL:(NSURL*)url {
  self.textureURL = url;
  if (self = [super initWithFrame:CGRectZero]) {    
  }
  return self;
}

- (void) dealloc {
  [color release];
  [geometry release];
  [texture release];
  [textureName release];
  [textureURL release];
  [artworkFetcher release];
  [textureImage release];
  [super dealloc];
}

- (void) buildView {
  self.hidden = NO;

  self.zrot = 0.0;
  
  switch (rand() % 4)
  {
    case 0:
      self.color = [UIColor blueColor];
      break;
    case 1:
      self.color = [UIColor redColor];
      break;
    case 2:
      self.color = [UIColor greenColor];
      break;
    case 3:
      self.color = [UIColor yellowColor];
      break;
  }
  
	self.frame = CGRectMake(0,0,0,0);
  
  if (self.geometry == nil)
  {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"sphere" ofType:@"obj"];
    self.geometry = [[Geometry newOBJFromResource:path] autorelease];
    self.geometry.cullFace = NO;
  }
  
  if (self.texture == nil)
  {
    self.textureImage = [UIImage imageNamed:self.textureName];
    self.texture = [[Texture newTextureFromImage:self.textureImage.CGImage] autorelease];
  }

  if (self.textureURL) {
    self.artworkFetcher = [[[AsyncArtworkFetcher alloc] init] autorelease];
    artworkFetcher.url = self.textureURL;
    artworkFetcher.delegate = self;
    NSLog(@"[SV] fetching image at %@", self.textureURL);
    [artworkFetcher fetch];    
  }
}

- (void) drawInGLContext {
  
  glScalef (500, 500, 500);
  glRotatef (180, 1, 0, 0);

// Use this rotation to correct the sphere.obj
//  glRotatef (-90, 1, 0, 0);
//  glRotatef (90, 0, 1, 0);  
//  [self updateTexture];

  glDepthMask(0);
  if (textureImage == nil) {
    [self.geometry displayWireframe];
  } else {
    // TODO: figure out why this geometry disappears sometimes after a few seconds
    [Geometry displaySphereWithTexture:self.texture];
    //[self.geometry displayFilledWithTexture:self.texture];
  }

  glDepthMask(1);
}

- (void) didReceiveFocus {
}

- (void) updateTexture {
  [texture replaceTextureWithImage:self.textureImage.CGImage];
}

- (void)artworkFetcher:(AsyncArtworkFetcher *)fetcher didFinish:(UIImage *)artworkImage {  
  [self updateImage:artworkImage];
}

- (void) updateImage:(UIImage*)img {
  NSLog(@"[SV] resizing image from original: %f, %f", img.size.width, img.size.height);
  img = [self resizeImage:img];
  //NSLog(@"[SV] DONE: %f, %f", img.size.width, img.size.height);
  self.textureImage = img;
  [self updateTexture];
}

- (UIImage*) resizeImage:(UIImage*)originalImage {
	CGPoint topCorner = CGPointMake(0, 0);
	CGSize targetSize = CGSizeMake(512, 256);	
	
	UIGraphicsBeginImageContext(targetSize);	
	[originalImage drawInRect:CGRectMake(0, 0, 512, 256)];	
	UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();	
	
	return result;	
}



@end
