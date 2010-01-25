//
//  Copyright 2010 Spot Metrix, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SM3DAR.h"
#import "AsyncArtworkFetcher.h"

@interface SphereView : SM3DAR_PointView {
  double zrot;
  UIColor * color;
  Geometry * geometry;
  Texture * texture;
  NSString * textureName;
  NSURL * textureURL;
  UIImage * textureImage;
  AsyncArtworkFetcher *artworkFetcher;
}

@property (nonatomic) double zrot;
@property (nonatomic, retain) UIColor * color;
@property (nonatomic, retain) Geometry * geometry;
@property (nonatomic, retain) Texture * texture;
@property (nonatomic, retain) NSString * textureName;
@property (nonatomic, retain) NSURL * textureURL;
@property (nonatomic,retain) AsyncArtworkFetcher *artworkFetcher;
@property (nonatomic,retain) UIImage * textureImage;

- (id) initWithTextureNamed:(NSString*)name;
- (id) initWithTextureURL:(NSURL*)url;
- (void) drawInGLContext;
- (void) updateTexture;
- (void) updateImage:(UIImage*)newImage;
- (UIImage*) resizeImage:(UIImage*)originalImage;
- (void) fetchTextureImage:(NSURL*)url;
@end
