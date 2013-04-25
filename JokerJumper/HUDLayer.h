//
//  HUDLayer.h
//  JokerJumper
//
//  Created by Sun on 3/31/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Constants.h"
#import "GameLayer.h"
#import "GameLayer2.h"
#import "GameLayer3.h"
#import "SimpleAudioEngine.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HUDLayer : CCLayer {
    CCLabelTTF *lifeLabel;
    CCLabelTTF *statusLabel;
    CCLabelTTF *coinLabel;
    CCMenuItemImage *pause;
    CCSprite *coinBar;
    CCSprite *disBar;
    CCSprite *lifeBar;
    CCSprite *moon;
    CCSpriteBatchNode* moonBatchNode;
    
    GameLayer *gameLayer;
    GameLayer2 *gameLayer2;
    GameLayer3 *gameLayer3;
}
-(void) updateLifeCounter:(int)amount;
-(void) updateCoinCounter:(int)amount;
-(void) updateStatusCounter:(float)amount;
-(void) zoomCoin;
-(void) zoomLife;
+(HUDLayer*) getHUDLayer;

//@property (nonatomic, readwrite)CCLabelBMFont * lifeLabel;
//@property (nonatomic, readwrite)CCLabelBMFont * statusLabel;
//@property (nonatomic, readwrite)CCLabelBMFont * coinLabel;

- (id) initWithLevel:(int)level;
@end

