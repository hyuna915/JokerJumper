//
//  VideoScene.m
//  JokerJumper
//
//  Created by Sun on 4/30/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "VideoScene.h"
#import "CCVideoPlayer.h"
#import "VideoLayer.h"


@implementation VideoScene

+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    VideoScene *layer = [VideoScene node];
    [scene addChild:layer z:3];
    
    
	// 'layer' is an autorelease object.
	VideoLayer *videoLayer = [VideoLayer node];
	// add layer as a child to scene
	[scene addChild: videoLayer z:1 ];
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
        
    }
    return self;
}

@end
