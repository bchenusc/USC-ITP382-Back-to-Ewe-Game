//
//  Node.h
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class GameplayScene;
#import "GameplayVariables.h"

@interface Node : CCNode {
    CGFloat m_Radius;
    GameplayScene* m_GameplayScene;
    bool m_BeingRemoved;
    CGFloat m_ShrinkTime;
}

@property (readonly) CGFloat radius;

- (void) initWithSprite:(enum GameLevel) level;

- (void) setGameplayScene:(GameplayScene*)g;

- (void) shrinkAndRemove;

- (CGRect) rect;

- (bool) isPointInNode:(CGPoint)point;

@end
