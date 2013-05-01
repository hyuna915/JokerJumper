//
//  MainMenuLayer.m
//  JokerJumper
//
//  Created by Sun on 2/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "CCControlButton.h"
#import "CCBReader.h"
#import "LevelScrollScene.h"
#import "GameScene.h"
#import "Constants.h"
#import "SimpleAudioEngine.h"
#import "VideoScene.h"

#define PLAY_BUTTON_TAG 1
#define OPTIONS_BUTTON_TAG 2
#define ABOUT_BUTTON_TAG 3

CCSprite *bg;
CCSprite *play;
CCSprite* joker;
CCSprite* enemy1;
CCSprite* enemy2;
CCSprite* enemy3;
CCSprite* enemy4;
CCSprite* cloudleft;
CCSprite* cloudright;
CCSprite* caption;
CCSprite* light;
CCSprite* sun;
CCSprite* grass;

//CCSpriteBatchNode* bgBatchNode;
CCSpriteBatchNode* playButtonBatchNode;
CCSpriteBatchNode* characterBatchNode;
CCSpriteBatchNode* enemy2BatchNode;
CCSpriteBatchNode* captionBatchNode;

CCFiniteTimeAction *moveAction1;
CCFiniteTimeAction *moveAction2;
CCFiniteTimeAction *moveAction3;
CCFiniteTimeAction *moveAction4;

int cloudCount;
int cloudMoveOutCount;
CGSize winSize;

@implementation MainMenuLayer

- (void)preLoadSoundFiles
{
    SimpleAudioEngine *sae = [SimpleAudioEngine sharedEngine];
    if (sae != nil) {
        [sae preloadBackgroundMusic:@"background_music.mp3"];
        if (sae.willPlayBackgroundMusic) {
            sae.backgroundMusicVolume = 0.5f;
        }
    }
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background_music.mp3"];
}

- (id) init {
    self = [super init];
    if (self) {
        winSize = [[CCDirector sharedDirector] winSize];
        
        [self preLoadSoundFiles];
        
        bg = [CCSprite spriteWithFile:@"bg.png"];
        bg.anchorPoint = ccp(0, 0);
        [self addChild: bg z:-10];
        
        // Play Button
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btn_play_rot_default.plist"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"all_character_default.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pokerSoilder_default.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"caption_default.plist"];
        
        playButtonBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"btn_play_rot_default.png"];
        
        characterBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"all_character_default.png"];
        enemy2BatchNode=[CCSpriteBatchNode batchNodeWithFile:@"pokerSoilder_default.png"];
        captionBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"caption_default.png"];
        [self addChild:characterBatchNode z:1];
        [self addChild:enemy2BatchNode z:2];
        [self addChild:playButtonBatchNode z:10];
        [self addChild:captionBatchNode z:10];
        
        light=[CCSprite spriteWithFile:@"light.png"];
        light.opacity=50;
        CCRotateBy *rot = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:20.0 angle: 360]];
        [light runAction:rot];
        light.position=ccp(504, 212);
        [self addChild:light z:-4];
        
        sun=[CCSprite spriteWithFile:@"sun.png"];
        sun.position=ccp(534,462);
        [self addChild:sun z:-3];
        
        grass=[CCSprite spriteWithFile:@"ground.png"];
        grass.position=ccp(512,68);
        [self addChild:grass z:-1];
        
        play = [CCSprite spriteWithSpriteFrameName:@"btn_play_rot0.png"];
        NSMutableArray *bgAnimFrames = [NSMutableArray array];
        for(int i = 0; i <= 14; ++i) {
            [bgAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"btn_play_rot%d.png", i]]];
        }
        
        CCAnimation *playRunAnimation = [CCAnimation animationWithSpriteFrames:bgAnimFrames delay:0.1f];
        CCAction *playRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: playRunAnimation]];
        [play setTexture:[playButtonBatchNode texture]];
        [play runAction:playRunAction];
        play.anchorPoint = ccp(0, 0);
        play.scale = 1.5;
        [playButtonBatchNode addChild:play z:1];
        play.position = ccp(344, 0);
        
        caption = [CCSprite spriteWithSpriteFrameName:@"caption0.png"];
        NSMutableArray *caAnimFrames = [NSMutableArray array];
        for(int i = 0; i <= 11; ++i) {
            [caAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"caption%d.png", i]]];
        }
        
        CCAnimation *captionRunAnimation = [CCAnimation animationWithSpriteFrames:caAnimFrames delay:0.1f];
        CCAction *captionRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: captionRunAnimation]];
        [caption setTexture:[captionBatchNode texture]];
        [caption runAction:captionRunAction];
        caption.anchorPoint = ccp(0, 0);
        [captionBatchNode addChild:caption z:1];
        caption.position = ccp(264, 462);
        
        joker=[CCSprite spriteWithSpriteFrameName:@"joker1.png"];
        enemy1=[CCSprite spriteWithSpriteFrameName:@"green_monster0.png"];
        enemy2=[CCSprite spriteWithSpriteFrameName:@"pokerSoilder0.png"];
        enemy3=[CCSprite spriteWithSpriteFrameName:@"enermy1.png"];
        
        joker.position=ccp(0,160);
        enemy1.position=ccp(-150,160);
        enemy2.position=ccp(-250,300);
        enemy3.position=ccp(-350,160);
        
        NSMutableArray *jokerrunAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 14; ++i) {
            [jokerrunAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"joker%d.png", i]]];
        }
        CCAnimation *jokerRunAnimation = [CCAnimation animationWithSpriteFrames:jokerrunAnimFrames delay:0.09f];
        CCAction *jokerRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: jokerRunAnimation]];
        jokerRunAction.tag = jokerRunActionTag;
        [joker runAction:jokerRunAction];
        [characterBatchNode addChild:joker];
        moveAction1=[CCRepeat actionWithAction: [CCMoveTo actionWithDuration:6.0f position:ccp(winSize.width+500,160)] times:1];
        joker.scale=1.5;
        [joker runAction:moveAction1];
        
        NSMutableArray *enemy1runAnimFrames = [NSMutableArray array];
        for(int i = 0; i <= 7; ++i) {
            [enemy1runAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"green_monster%d.png", i]]];
        }
        CCAnimation *enemy1RunAnimation = [CCAnimation animationWithSpriteFrames:enemy1runAnimFrames delay:0.09f];
        CCAction *enemy1RunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: enemy1RunAnimation]];
        enemy1.scale=1.5;
        [enemy1 runAction:enemy1RunAction];
        [characterBatchNode addChild:enemy1];
        moveAction2=[CCRepeat actionWithAction: [CCMoveTo actionWithDuration:6.0f position:ccp(winSize.width+500,160)] times:1];
        [enemy1 runAction: moveAction2];
        
        NSMutableArray *enemy2runAnimFrames = [NSMutableArray array];
        for(int i = 0; i <= 9; ++i) {
            [enemy2runAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"pokerSoilder%d.png", i]]];
        }
        CCAnimation *enemy2RunAnimation = [CCAnimation animationWithSpriteFrames:enemy2runAnimFrames delay:0.09f];
        CCAction *enemy2RunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: enemy2RunAnimation]];
        enemy2RunAction.tag = jokerRunActionTag;
        enemy2.scale=1.5;
        [enemy2 runAction:enemy2RunAction];
        [enemy2BatchNode addChild:enemy2];
        moveAction3=[CCRepeat actionWithAction: [CCMoveTo actionWithDuration:6.0f position:ccp(winSize.width+500,300)] times:1];
        [enemy2 runAction: moveAction3];
        
        NSMutableArray *enemy3runAnimFrames = [NSMutableArray array];
        for(int i = 0; i <= 7; ++i) {
            [enemy3runAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"enermy%d.png", i]]];
        }
        CCAnimation *enemy3RunAnimation = [CCAnimation animationWithSpriteFrames:enemy3runAnimFrames delay:0.09f];
        CCAction *enemy3RunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: enemy3RunAnimation]];
        enemy3RunAction.tag = jokerRunActionTag;
        enemy3.scale=1.5;
        [characterBatchNode addChild:enemy3];
        [enemy3 runAction:enemy3RunAction];
        moveAction4=[CCRepeat actionWithAction: [CCMoveTo actionWithDuration:9.0f position:ccp(winSize.width+500,160)] times:1];
        [enemy3 runAction: moveAction4];
        
        
        
        // Create Play Button
        CCMenuItem *playButton = [CCMenuItemImage itemWithNormalImage:@"btn_play0.png" selectedImage:@"btn_play0.png" target:self selector:@selector(buttonReplayAction:)];
        playButton.scale = 1.3;
        CCMenu *Menu = [CCMenu menuWithItems:playButton, nil];
        Menu.position=ccp(500, 80);
        
        Menu.opacity = 0;
        
        [self addChild:Menu z:1];
        [self schedule:@selector(updateObject:) interval:10.0f];
        
        // Create Help Button
        CCMenuItem *helpButton = [CCMenuItemImage itemWithNormalImage:@"btn_help.png" selectedImage:@"btn_help.png" target:self selector:@selector(buttonHelpAction:)];
        helpButton.scale = 1.3;
        CCMenu *Menu2 = [CCMenu menuWithItems:helpButton, nil];
        Menu2.position=ccp(920, 80);
        
        [self addChild:Menu2 z:10];

//        helpMenu = [CCSprite spriteWithFile:@"help_menu.png"];
//        helpMenu.anchorPoint = ccp(0, 0);
//        helpMenu.visible = false;

        helpMenuButton = [CCMenuItemImage itemWithNormalImage:@"help_menu.png" selectedImage:@"help_menu.png" target:self selector:@selector(helpMenuAction:)];
        helpMenuButton.anchorPoint = ccp(0, 0);
        helpMenuButton.visible = false;
        
        CCMenu *Menu3 = [CCMenu menuWithItems:helpMenuButton, nil];
        Menu3.anchorPoint = ccp(0, 0);
        Menu3.position=ccp(0, 0);
        
        
//        helpMenu.scale = 0.8;

//        helpMenu.position = ccp(20, 140);
        [self addChild:Menu3 z:20];
        
        // Cloud Left
        cloudLeft0 = [CCSprite spriteWithFile:@"cloud_left0.png"];
        cloudLeft0.anchorPoint = ccp(0,0);
        cloudLeft0.position = ccp(-700, 100);
        [self addChild:cloudLeft0 z:-5];
        
        cloudLeft1 = [CCSprite spriteWithFile:@"cloud_left1.png"];
        cloudLeft1.anchorPoint = ccp(0,0);
        cloudLeft1.position = ccp(-700, 100);
        [self addChild:cloudLeft1 z:-4];

        cloudLeft2 = [CCSprite spriteWithFile:@"cloud_left2.png"];
        cloudLeft2.anchorPoint = ccp(0,0);
        cloudLeft2.position = ccp(-600, 100);
        [self addChild:cloudLeft2 z:-3];
        
        cloudLeft3 = [CCSprite spriteWithFile:@"cloud_left3.png"];
        cloudLeft3.anchorPoint = ccp(0,0);
        cloudLeft3.position = ccp(-600, 70);
        [self addChild:cloudLeft3 z:-2];

        // Cloud Right
        cloudRight0 = [CCSprite spriteWithFile:@"cloud_right0.png"];
        cloudRight0.anchorPoint = ccp(0, 0);
        cloudRight0.position = ccp(1034, 100);
        [self addChild:cloudRight0 z:-5];
        
        cloudRight1 = [CCSprite spriteWithFile:@"cloud_right1.png"];
        cloudRight1.anchorPoint = ccp(0, 0);
        cloudRight1.position = ccp(1034, 100);
        [self addChild:cloudRight1 z:-4];

        cloudRight2 = [CCSprite spriteWithFile:@"cloud_right2.png"];
        cloudRight2.anchorPoint = ccp(0, 0);
        cloudRight2.position = ccp(1034, 100);
        [self addChild:cloudRight2 z:-3];

        cloudRight3 = [CCSprite spriteWithFile:@"cloud_right3.png"];
        cloudRight3.anchorPoint = ccp(0, 0);
        cloudRight3.position = ccp(1034, 70);
        
        [self addChild:cloudRight3 z:-2];


        [self schedule:@selector(updateCloudMoveIn:) interval:2.0f];
        
        cloudL0 = [CCMoveTo actionWithDuration:4.0f position:ccp(-216,100)];
        [cloudLeft0 runAction:cloudL0];
        
        cloudR0 = [CCMoveTo actionWithDuration:4.0f position:ccp(584, 100)];
        [cloudRight0 runAction:cloudR0];
    }
    return self;
}

- (void)updateCloudMoveIn:(ccTime) dt
{
    cloudCount++;
    switch (cloudCount) {
        case 1:
            cloudL1 = [CCMoveTo actionWithDuration:4.0f position:ccp(-116,100)];
            [cloudLeft1 runAction:cloudL1];
            
            cloudR1 = [CCMoveTo actionWithDuration:4.0f position:ccp(594, 100)];
            [cloudRight1 runAction:cloudR1];
            break;
        case 2:
            cloudL2 = [CCMoveTo actionWithDuration:4.0f position:ccp(-26,100)];
            [cloudLeft2 runAction:cloudL2];
            
            cloudR2 = [CCMoveTo actionWithDuration:4.0f position:ccp(604, 100)];
            [cloudRight2 runAction:cloudR2];

            break;
        case 3:
            cloudL3 = [CCMoveTo actionWithDuration:4.0f position:ccp(-26,70)];
            [cloudLeft3 runAction:cloudL3];
            
            cloudR3 = [CCMoveTo actionWithDuration:4.0f position:ccp(604, 70)];
            [cloudRight3 runAction:cloudR3];

            break;
        default:
            [self unschedule:@selector(updateCloudMoveIn:)];
            cloudCount = 0;
            break;
    }
}

- (void)updateObject:(ccTime) dt
{
    joker.position=ccp(0,160);
    enemy1.position=ccp(-150,160);
    enemy2.position=ccp(-250,300);
    enemy3.position=ccp(-350,160);
    
    [joker runAction: moveAction1];
    [enemy1 runAction: moveAction2];
    [enemy2 runAction: moveAction3];
    [enemy3 runAction: moveAction4];
    
}

-(void) helpMenuAction:(id)sender {
    helpMenuButton.visible = false;
}

-(void) buttonHelpAction:(id)sender {
    if(helpMenuButton.visible == true)
        helpMenuButton.visible = false;
    else
        helpMenuButton.visible = true;
}

- (void)updateCloudMoveOut:(ccTime) dt
{
    cloudMoveOutCount++;
    switch (cloudMoveOutCount) {
        case 1:
            [cloudLeft1 stopAllActions];
            cloudL1 = [CCMoveTo actionWithDuration:0.1f position:ccp(-700, 100)];
            [cloudLeft1 runAction:cloudL1];
            
            [cloudRight1 stopAllActions];
            cloudR1 = [CCMoveTo actionWithDuration:0.1f position:ccp(1234, 100)];
            [cloudRight1 runAction:cloudR1];
            break;
        case 2:
            [cloudLeft2 stopAllActions];
            cloudL2 = [CCMoveTo actionWithDuration:0.1f position:ccp(-600, 100)];
            [cloudLeft2 runAction:cloudL2];
            
            [cloudRight2 stopAllActions];
            cloudR2 = [CCMoveTo actionWithDuration:0.1f position:ccp(1234, 100)];
            [cloudRight2 runAction:cloudR2];
            
            break;
        case 3:
            [cloudLeft3 stopAllActions];
            cloudL3 = [CCMoveTo actionWithDuration:0.1f position:ccp(-600, 70)];
            [cloudLeft3 runAction:cloudL3];
            
            [cloudRight3 stopAllActions];
            cloudR3 = [CCMoveTo actionWithDuration:0.1f position:ccp(1034, 70)];
            [cloudRight3 runAction:cloudR3];
            
            break;
        default:
            [self unschedule:@selector(updateCloudMoveOut:)];
            cloudMoveOutCount = 0;
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[LevelScrollScene scene]]];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[VideoScene scene]]];
            break;
    }
}

-(void)allCloudMoveOut {
    [cloudLeft1 stopAllActions];
    cloudL1 = [CCMoveTo actionWithDuration:0.5f position:ccp(-700, 100)];
    [cloudLeft1 runAction:cloudL1];
    
    [cloudRight1 stopAllActions];
    cloudR1 = [CCMoveTo actionWithDuration:0.5f position:ccp(1234, 100)];
    [cloudRight1 runAction:cloudR1];
    
    [cloudLeft2 stopAllActions];
    cloudL2 = [CCMoveTo actionWithDuration:0.5f position:ccp(-600, 100)];
    [cloudLeft2 runAction:cloudL2];
    
    [cloudRight2 stopAllActions];
    cloudR2 = [CCMoveTo actionWithDuration:0.5f position:ccp(1234, 100)];
    [cloudRight2 runAction:cloudR2];
    
    [cloudLeft3 stopAllActions];
    cloudL3 = [CCMoveTo actionWithDuration:0.5f position:ccp(-600, 70)];
    [cloudLeft3 runAction:cloudL3];
    
    [cloudRight3 stopAllActions];
    cloudR3 = [CCMoveTo actionWithDuration:0.5f position:ccp(1034, 70)];
    [cloudRight3 runAction:cloudR3];
}


-(void) buttonReplayAction:(id)sender {
    cloudCount = 0;
    
    [self unschedule:@selector(updateCloudMoveIn:)];
    
    [cloudLeft0 stopAllActions];
    cloudL0 = [CCMoveTo actionWithDuration:0.1f position:ccp(-700, 100)];
    [cloudLeft0 runAction:cloudL0];
    
    [cloudRight0 stopAllActions];
    cloudR0 = [CCMoveTo actionWithDuration:0.1f position:ccp(1234, 100)];
    [cloudRight0 runAction:cloudR0];
    [self allCloudMoveOut];
    [self schedule:@selector(updateCloudMoveOut:) interval:0.1f];
//    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[LevelScrollScene scene]]];
//    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[VideoScene scene]]];
}


-(void) buttonOptionAction:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"OptionsScene.ccbi"]]];
}

-(void) buttonAboutAction:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"AboutScene.ccbi"]]];
}

//-(void)buttonPressed:(id)sender {
//    CCControlButton *button = (CCControlButton*) sender;
//    switch (button.tag) {
//        case PLAY_BUTTON_TAG:
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[LevelScrollScene scene]]];
////            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"LevelScene.ccbi"]]];
//            break;
//        case OPTIONS_BUTTON_TAG:
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"OptionsScene.ccbi"]]];
//            break;
//        case ABOUT_BUTTON_TAG:
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"AboutScene.ccbi"]]];
//            break;
//    }
//}

@end