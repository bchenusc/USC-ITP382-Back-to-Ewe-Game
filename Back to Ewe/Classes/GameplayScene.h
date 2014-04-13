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
#import "GrassGenerator.h"
#import "PowerupGenerator.h"

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
    NSMutableArray* grass;
    
    CGPoint scrollCenter;
    float scrollSpeed;
    
    UILayer* m_UILayer;
    NodeGenerator* nodeGenerator;
    CGPoint topNode;
    EnemyGenerator* enemyGenerator;
    Enemy* topEnemy;
    GrassGenerator* grassGenerator;
    Grass* topGrass;
    PowerupGenerator* powerupGenerator;
    Powerup* topPowerup;
    float powerupSpacing;
    float powerupSpacingTolerance;
    
    float score;
    int m_PlayerLives; 
}

// -----------------------------------------------------------------------

+ (GameplayScene *)scene;
- (void) addNode : (Node*) n Position: (CGPoint) point;
- (void) removeNode:(Node*)toRemove;
- (void) removeGrass;
- (CGSize) getSize;
- (id)init;
- (void)spawnNewPattern;
- (void)spawnNewEnemy;
- (void) spawnNewGrass;
- (void) playerDeath;
- (void) gameOver;

// -----------------------------------------------------------------------
@end