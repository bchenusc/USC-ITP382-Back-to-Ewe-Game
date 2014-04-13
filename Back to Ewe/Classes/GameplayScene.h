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
@class NodeGenerator;
#import "NodeGenerator.h"
#import "EnemyGenerator.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface GameplayScene : CCScene <CCPhysicsCollisionDelegate> {
    Sheep* sheep;
    CCPhysicsNode* physics;
    NSMutableArray* enemies;
    NSMutableArray* nodes;
    NSMutableArray* nodesToDelete;
    
    CGPoint scrollCenter;
    float scrollSpeed;
    
    UILayer* m_UILayer;
    NodeGenerator* nodeGenerator;
    CGPoint topNode;
    EnemyGenerator* enemyGenerator;
    Enemy* topEnemy;
    int score;
}

// -----------------------------------------------------------------------

+ (GameplayScene *)scene;
- (void) addNode : (Node*) n Position: (CGPoint) point;
- (void) removeNode:(Node*)toRemove;
- (CGSize) getSize;
- (id)init;
- (void)spawnNewPattern;
-(void)spawnNewEnemy;

// -----------------------------------------------------------------------
@end