//
//  Projectile.h
//  Back to Ewe
//
//  Created by Jeffrey on 4/13/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Projectile : CCDrawNode {
    CCSprite* sprite;
    int m_Speed;
    CGPoint m_Target;
}

- (instancetype) initWithTarget:(CGPoint)projectileTarget atPosition:(CGPoint) initialPosition;

@property CGPoint Target;

@end
