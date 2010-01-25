//
//  Copyright 2010 Spot Metrix, Inc. All rights reserved.
//

#import "AnimatedSphereView.h"
//#import <OpenGLES/ES1/gl.h>

@implementation AnimatedSphereView

@synthesize textureNames;

- (void) dealloc {
  [textureNames release];
  [super dealloc];
}


int currentTexture = 0;
int frameCount = 0;

- (NSString*) nextTextureName {  
  if (frameCount++ % 100 == 0) {
    frameCount = 0;
    currentTexture++;
    
    if (currentTexture >= [self.textureNames count])
      currentTexture = 0;
  }
  
  return [self.textureNames objectAtIndex:currentTexture];
}

- (void) updateTexture {
  if (!self.textureNames) {
    self.textureNames = [NSArray arrayWithObjects:
                         @"audacity-hdh-week-41.png",	
                         @"spheremap_norm.png",		
                         @"world.png",
                         @"ingiltere-bayragi.png",		
                         @"timezone.png", nil];                         
  }
  
  [texture replaceTextureFromResource:[self nextTextureName]];

}


@end
