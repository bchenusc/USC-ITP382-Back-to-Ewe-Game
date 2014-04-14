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
    Sheep* m_Sheep;
    CCPhysicsNode* physics;
    NSMutableArray* nodes;
    NSMutableArray* nodesToDelete;
    NSMutableArray* grass;
    NSMutableArray* enemies;
    
    CGPoint newNodePoint;
    
    UILayer* m_UILayer;
    NodeGenerator* nodeGenerator;
    CGPoint topNode;
    EnemyGenerator* enemyGenerator;
    Enemy* topEnemy;
    BOOL m_CanSpawnEnemies;
    GrassGenerator* grassGenerator;
    Grass* topGrass;
    PowerupGenerator* powerupGenerator;
    Powerup* topPowerup;
    Powerup* powerupToDelete;
    float nextPowerupSpawnYPos;
    float powerupSpacing;
    
    bool bossLevel;
    
    float m_Score;
    int m_PlayerLives;
    bool m_Dead;
    
    bool m_Paused;
}

// -----------------------------------------------------------------------

+ (GameplayScene *)scene;
- (void) addNode : (Node*) n Position: (CGPoint) point;
- (void) removeNode:(Node*)toRemove;
- (void) removeGrass;
- (CGSize) getSize;
- (void) setNewNodePoint : (CGPoint) point;
- (CGPoint) getNewNodePoint;
- (id)init;
- (void)spawnNewPattern;
- (void)spawnNewEnemy;
- (void) spawnNewGrass;
- (void) detonateBomb;
- (void) playerDeath;
- (void) resetGame;
- (void) respawnPlayer;
- (void) gameOver;
- (void) pause;
- (void) resume;

// -----------------------------------------------------------------------
@end