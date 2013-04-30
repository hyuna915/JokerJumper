//
//  MainMenuLayer.h
//  JokerJumper
//
//  Created by Sun on 2/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MainMenuLayer : CCLayer {
//    CCSprite *helpMenu;
    CCMenuItem *helpMenuButton;
    
    CCSprite *cloudLeft0;
    CCSprite *cloudLeft1;
    CCSprite *cloudLeft2;
    CCSprite *cloudLeft3;
    
    CCSprite *cloudRight0;
    CCSprite *cloudRight1;
    CCSprite *cloudRight2;
    CCSprite *cloudRight3;
    
    CCFiniteTimeAction *cloudL0;
    CCFiniteTimeAction *cloudL1;
    CCFiniteTimeAction *cloudL2;
    CCFiniteTimeAction *cloudL3;
    
    CCFiniteTimeAction *cloudR0;
    CCFiniteTimeAction *cloudR1;
    CCFiniteTimeAction *cloudR2;
    CCFiniteTimeAction *cloudR3;

}

@end
