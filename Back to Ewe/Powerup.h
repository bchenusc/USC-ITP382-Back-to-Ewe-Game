//
//  Powerup.h
//  Back to Ewe
//
//  Created by David Zhang on 4/12/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum PowerupType {
    shield = 0,
    unlimitedWool,
    puffBomb,
    health,
    projectile,
    powerupTypeMax,
    NONE
};

@interface Powerup : CCNode {
    CGFloat m_Radius;
    
    enum PowerupType m_PowerupType;
    
    CCLabelTTF* m_PowerupLabel;
    
    CCSprite* m_Sprite;
}

@property CGFloat radius;
@property enum PowerupType POWERUPTYPE;

-(void) setRandomPowerupType;

- (void) setProjectileType;

- (CGRect) rect;

- (BOOL) isPointInPowerup:(CGPoint)point;

@end