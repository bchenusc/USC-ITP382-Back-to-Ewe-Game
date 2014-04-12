//
//  Enemy.h
//  Back to Ewe
//
//  Created by David Zhang on 4/7/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum EnemyType {
    horizontalMover = 0,
    verticalMover,
    stationary,
    expander,
    EnemyTypeMax
};

@interface Enemy : CCDrawNode {
    CGFloat m_Radius;
    
    enum EnemyType m_EnemyType;
    
    CGPoint m_CenterPosition;
    float m_MovementBounds;
    float m_MovementSpeed;
}

@property CGFloat radius;
@property enum EnemyType ENEMYTYPE;

-(void) setRandomEnemyType;

-(void) setPositionAndCenter:(CGPoint)point;

- (CGRect) rect;

- (BOOL) isPointInEnemy:(CGPoint)point;

@end