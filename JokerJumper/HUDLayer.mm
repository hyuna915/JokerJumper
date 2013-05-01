//
//  HUDLayer.m
//  JokerJumper
//
//  Created by Sun on 3/31/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"
#import "GameScene.h"

@implementation HUDLayer
//@synthesize    lifeLabel;
//@synthesize    statusLabel;
//@synthesize    coinLabel;

int hudLevel;
int pauseStat;

+(HUDLayer*) getHUDLayer {
    return self;
}


-(id) init
{
	if ((self = [super init]))
	{
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.tag=HUD_LAYER_TAG;
        coinBar= [CCSprite spriteWithSpriteFrameName:@"diamond5.png"];
        disBar=[CCSprite spriteWithFile:@"spade.png"];
        lifeBar=[CCSprite spriteWithSpriteFrameName:@"heart5.png"];
        
        coinBar.position = ccp(COIN_LABEL_X,screenSize.height-30);
        disBar.position = ccp(STATUS_LABEL_X, screenSize.height-30);
        lifeBar.position=ccp(LIFE_LABEL_X, screenSize.height-30);
                
        // These values are hard coded for Drivers Ed, should be refacotred for more flexability
            
        statusLabel = [CCLabelTTF labelWithString:@"0.0" fontName:@"Mountains of Christmas" fontSize:20];
        lifeLabel=[CCLabelTTF labelWithString:@"0" fontName:@"Mountains of Christmas" fontSize:20];
        coinLabel=[CCLabelTTF labelWithString:@"0" fontName:@"Mountains of Christmas" fontSize:20];
        [statusLabel setColor:ccORANGE];
        [lifeLabel setColor:ccORANGE];
        [coinLabel setColor:ccORANGE];
        [statusLabel setAnchorPoint:ccp(0.5f,1)];
        [coinLabel setAnchorPoint:ccp(0.5f,1)];
        [lifeLabel setAnchorPoint:ccp(0.5f,1)];
        [statusLabel setPosition:ccp(STATUS_LABEL_X+OFFSET_X,screenSize.height-30)];
        [coinLabel setPosition:ccp(COIN_LABEL_X+OFFSET_X,screenSize.height-30)];
        [lifeLabel setPosition:ccp(LIFE_LABEL_X+OFFSET_X,screenSize.height-30)];
		        
        pause = [CCMenuItemImage itemFromNormalImage:@"pauseButton.png" selectedImage:@"pauseButtonPressed.png" target:self selector:@selector(pauseButtonSelected)];
        CCMenu *menu = [CCMenu menuWithItems:pause, nil];
        menu.position = CGPointMake(35, screenSize.height - 30);
        
        [self addChild:menu z:100];
        [self addChild:coinBar z:100];
        [self addChild:disBar z:100];
        [self addChild:lifeBar z:100];
        [self addChild:statusLabel z:100];
        [self addChild:coinLabel z:100];
        [self addChild:lifeLabel z:100];
    }
	
	return self;
}

- (id) initWithLevel:(int)level {
    self = [super init];
    if (self) {
        hudLevel = level;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.tag=HUD_LAYER_TAG;
        coinBar= [CCSprite spriteWithSpriteFrameName:@"diamond5.png"];
        disBar=[CCSprite spriteWithFile:@"spade.png"];
        lifeBar=[CCSprite spriteWithSpriteFrameName:@"heart5.png"];
        
        coinBar.position = ccp(COIN_LABEL_X,screenSize.height-30);
        disBar.position = ccp(STATUS_LABEL_X, screenSize.height-30);
        lifeBar.position=ccp(LIFE_LABEL_X, screenSize.height-30);
        
        // These values are hard coded for Drivers Ed, should be refacotred for more flexability
        
        statusLabel = [CCLabelTTF labelWithString:@"0.0" fontName:@"Mountains of Christmas" fontSize:40];
        lifeLabel=[CCLabelTTF labelWithString:@"0" fontName:@"Mountains of Christmas" fontSize:40];
        coinLabel=[CCLabelTTF labelWithString:@"0" fontName:@"Mountains of Christmas" fontSize:40];
        [statusLabel setColor:ccORANGE];
        [lifeLabel setColor:ccORANGE];
        [coinLabel setColor:ccORANGE];
        [statusLabel setAnchorPoint:ccp(0.5f,1)];
        [coinLabel setAnchorPoint:ccp(0.5f,1)];
        [lifeLabel setAnchorPoint:ccp(0.5f,1)];
        [statusLabel setPosition:ccp(STATUS_LABEL_X+OFFSET_X,screenSize.height-30)];
        [coinLabel setPosition:ccp(COIN_LABEL_X+OFFSET_X,screenSize.height-30)];
        [lifeLabel setPosition:ccp(LIFE_LABEL_X+OFFSET_X,screenSize.height-30)];
        
        pause = [CCMenuItemImage itemWithNormalImage:@"btn_pause.PNG" selectedImage:@"btn_pause.PNG" target:self selector:@selector(pauseButtonSelected)];
        CCMenu *menu = [CCMenu menuWithItems:pause, nil];
        menu.position = CGPointMake(35, screenSize.height - 28);
        
        gravityButton = [CCMenuItemImage itemWithNormalImage:@"btn_gravity.png" selectedImage:@"btn_gravity.png" target:self selector:@selector(gravityButtonSelected)];
        
        CCMenu *menu2 = [CCMenu menuWithItems:gravityButton, nil];
        menu2.position = CGPointMake(95, screenSize.height - 25);
        
        pauseButton = [CCMenuItemImage itemWithNormalImage:@"btn_pause.PNG" selectedImage:@"btn_pause.PNG" target:self selector:@selector(pauseInvisibleButtonSelected)];
        pauseButton.scale = 2;
        CCMenu *menu3 = [CCMenu menuWithItems:pauseButton, nil];
        menu3.position = CGPointMake(950, 50);

        
        [self addChild:menu z:100];
        [self addChild:menu2 z:100];
        [self addChild:menu3 z:100];
        [self addChild:coinBar z:100];
        [self addChild:disBar z:100];
        [self addChild:lifeBar z:100];
        [self addChild:statusLabel z:100];
        [self addChild:coinLabel z:100];
        [self addChild:lifeLabel z:100];
    }
    return self;
}

- (void)pauseInvisibleButtonSelected {
//    [self zoomPauseButton];
    
    if(pauseStat == 0) {
        [[CCDirector sharedDirector] pause];
        pauseStat++;
    }
    else {
        [[CCDirector sharedDirector] resume];
        pauseStat--;
    }
}


- (void)pauseButtonSelected {
//    [self zoomPause];
    
    if (![[GameScene sharedGameScene] isShowingPausedMenu]) {
        [[GameScene sharedGameScene] setShowingPausedMenu:YES];
        [[GameScene sharedGameScene] showPausedMenu];
        [[CCDirector sharedDirector] pause];
    }
    
}

- (void)gravityButtonSelected {
    [self zoomGravityButton];
    
    CCScene* scene = [[CCDirector sharedDirector] runningScene];
    switch (hudLevel) {
        case GAME_STATE_ONE:
            gameLayer = (GameLayer*)[scene getChildByTag:GAME_LAYER_TAG];
            [gameLayer setGravityEffect];
            break;
        case GAME_STATE_TWO:
            gameLayer2 = (GameLayer2*)[scene getChildByTag:GAME_LAYER_TAG];
            [gameLayer2 setGravityEffect];
            break;
        case GAME_STATE_THREE:
            gameLayer3 = (GameLayer3*)[scene getChildByTag:GAME_LAYER_TAG];
            [gameLayer3 setGravityEffect];
            break;
        default:
            break;
    }
}

-(void) updateLifeCounter:(int)amount
{
    if(amount<2)
    {
        [lifeLabel setColor:ccRED];
    }
    else
    {
        [lifeLabel setColor:ccORANGE];
    }
        NSString *amounts = [NSString stringWithFormat:@"%d", amount];
        [lifeLabel setString:amounts];
}

-(void) updateCoinCounter:(int)amount
{
        NSString *amounts = [NSString stringWithFormat:@"%d", amount];
        [coinLabel setString:amounts];
}
-(void) updateStatusCounter:(float)amount
{
        NSString *amounts = [NSString stringWithFormat:@"%d", (int)amount];
        [statusLabel setString:amounts];
}

-(void) zoomCoin
{
    [self schedule:@selector(updateZoomCoin:) interval:0.05f];
}

-(void) zoomLife
{
    [self schedule:@selector(updateZoomLife:) interval:0.05f];
}


- (void)updateZoomCoin:(ccTime) dt {
    coinBar.scale += 0.1;
    if(coinBar.scale >= 1.5) {
        coinBar.scale = 1;
        [self unscheduleAllSelectors];
    }
}

- (void)updateZoomLife:(ccTime) dt {
    lifeBar.scale += 0.1;
    if(lifeBar.scale >= 1.5) {
        lifeBar.scale = 1;
        [self unscheduleAllSelectors];
    }
}

-(void) zoomGravityButton
{
    [self schedule:@selector(updateZoomGravityButton:) interval:0.05f];
}

-(void) updateZoomGravityButton:(ccTime) dt {
    gravityButton.scale += 0.1;
    if(gravityButton.scale >= 1.5) {
        gravityButton.scale = 1;
        [self unscheduleAllSelectors];
    }
}

-(void) zoomPause
{
    [self schedule:@selector(updateZoomPause:) interval:0.05f];
}

-(void) updateZoomPause:(ccTime) dt {
    pause.scale += 0.1;
    if(pause.scale >= 1.5) {
        pause.scale = 1;
        [self unscheduleAllSelectors];
    }
}

-(void) zoomPauseButton {
    [self schedule:@selector(updateZoomPauseButton:) interval:0.05f];
}

-(void) updateZoomPauseButton:(ccTime) dt {
    pauseButton.scale -= 0.1;
    if(pauseButton.scale <= 1.5) {
        pauseButton.scale = 2;
        [self unscheduleAllSelectors];
    }
}

@end
