//
//  Sheep.h
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Node.h"
#import "WoolString.h"
#import "Powerup.h"
@class GameplayScene;

@interface Sheep : CCSprite {
    WoolString* m_WoolString;
    Node* m_AttachedNode;
    NSMutableArray* m_CurrentPowerups;

    float m_currentWool;
    float m_maxWool;
    
    float m_currentHealth;
    float m_maxHealth;
    
    int m_numPuffBombs;
}

@property NSMutableArray* CurrentPowerups;
@property (readonly) Node* attachedNode;
@property float CurrentWool;
@property float MaxWool;
@property float CurrentHealth;
@property float MaxHealth;
@property int NumPuffBombs;

- (bool) stringToNode:(Node*)node;

- (void) addPowerup:(enum PowerupType)powerup;

- (void) breakString;

- (BOOL) hitEnemy;

- (void) reset;

- (void) spinIntoCenter;

@end
