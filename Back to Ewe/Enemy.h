//
//  Enemy.h
//  Back to Ewe
//
//  Created by David Zhang on 4/7/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Enemy : CCDrawNode {
    CGFloat m_Radius;
}

@property CGFloat radius;

- (CGRect) rect;

- (BOOL) isPointInEnemy:(CGPoint)point;

@end