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
    powerupTypeMax,
    NONE
};

@interface Powerup : CCDrawNode {
    CGFloat m_Radius;
    
    enum PowerupType m_PowerupType;
    
    CCLabelTTF* m_PowerupLabel;
}

@property CGFloat radius;
@property enum PowerupType POWERUPTYPE;

-(void) setRandomPowerupType;

- (CGRect) rect;

- (BOOL) isPointInPowerup:(CGPoint)point;

@end