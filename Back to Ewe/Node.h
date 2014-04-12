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

@interface Node : CCDrawNode {
    CGFloat m_Radius;
    GameplayScene* m_GameplayScene;
    BOOL m_BeingRemoved;
}

@property (readonly) CGFloat radius;

- (void) setGameplayScene:(GameplayScene*)g;

- (void) shrinkAndRemove;

- (CGRect) rect;

- (BOOL) isPointInNode:(CGPoint)point;

@end
