//
//  GameplayScene.h
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright Silly Landmine Studios 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "Sheep.h"
#import "UILayer.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface GameplayScene : CCScene <CCPhysicsCollisionDelegate> {
    Sheep* sheep;
    NSMutableArray* enemies;
    NSMutableArray* nodes;
    
    UILayer* m_UILayer;
}

// -----------------------------------------------------------------------

+ (GameplayScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end