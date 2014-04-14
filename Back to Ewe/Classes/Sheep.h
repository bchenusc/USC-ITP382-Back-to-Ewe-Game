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

@interface Sheep : CCDrawNode {
    WoolString* m_WoolString;
    Node* m_AttachedNode;
    NSMutableArray* m_CurrentPowerups;
    
    enum PowerupType m_CurrentPowerup;

    float m_currentWool;
    float m_maxWool;
    
    float m_currentHealth;
    float m_maxHealth;
    
    int m_numPuffBombs;
}

@property (readonly) enum PowerupType CurrentPowerup;
@property NSMutableArray* CurrentPowerups;
@property (readonly) Node* attachedNode;
@property float CurrentWool;
@property float MaxWool;
@property float CurrentHealth;
@property float MaxHealth;
@property int NumPuffBombs;

- (void) stringToNode:(Node*)node;

-(void) setPowerup:(enum PowerupType)powerup;

- (void) breakString;

@end
