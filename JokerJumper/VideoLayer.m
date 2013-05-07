//
//  VideoLayer.m
//  JokerJumper
//
//  Created by Sun on 4/30/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "VideoLayer.h"
#import "CCVideoPlayer.h"
#import "LevelScrollScene.h"
#import "SimpleAudioEngine.h"

@implementation VideoLayer



- (id) init {
    self = [super init];
    if (self) {
        [CCVideoPlayer setDelegate: self];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        
        [CCVideoPlayer playMovieWithFile: @"joker_jumper.mov"];
        [CCVideoPlayer setNoSkip: NO];
    }
    return self;
}


- (void) moviePlaybackFinished
{
    //    CCLOG(@"moviePlaybackFinished");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[LevelScrollScene scene]]];
}

- (void) movieStartsPlaying
{
    //    CCLOG(@"movieStartsPlaying");
}

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
// Updates orientation of CCVideoPlayer. Called from SharedSources/RootViewController.m
- (void) updateOrientationWithOrientation: (UIDeviceOrientation) newOrientation
{
    CCLOG(@"updateOrientationWithOrientation");
    [CCVideoPlayer updateOrientationWithOrientation:newOrientation ];
}
#endif
@end
