//
//  Sheep.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "Sheep.h"


@implementation Sheep

@synthesize CurrentPowerup = m_CurrentPowerup;
@synthesize attachedNode = m_AttachedNode;
@synthesize CurrentWool = m_currentWool;
@synthesize MaxWool = m_maxWool;
@synthesize CurrentHealth = m_currentHealth;
@synthesize MaxHealth = m_maxHealth;

- (instancetype)init {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        self.position = ccp(winSize.width / 2, 60);
        [self drawDot:ccp(0, 0) radius:30 color:[CCColor blueColor]];
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithCircleOfRadius:30 andCenter:self.anchorPointInPoints];
        //physics.elasticity = 4;
        physics.type = CCPhysicsBodyTypeDynamic;
        physics.collisionCategories = @[@"sheep"];
        physics.collisionMask = @[@"enemy", @"projectile", @"wall", @"node", @"grass", @"powerup"];
        physics.collisionType = @"sheep";
        self.physicsBody = physics;
        
        m_WoolString = nil;
        m_AttachedNode = nil;
        
        m_maxWool = 10000.0f;
        m_currentWool = m_maxWool;
        
        m_CurrentPowerup = NONE;
    }
    return self;
}

- (void) stringToNode:(Node*)node {
    NSAssert(node != nil, @"Argument must be non-nil");
    
    if (m_currentWool <= 0) {
        m_currentWool = 0;
        //NSLog(@"No wool");
        return;
    }
    
    m_AttachedNode = node;
    
    if (m_WoolString) {
        [m_WoolString invalidate];
        [self removeChild:m_WoolString];
        m_WoolString = nil;
    }
    
    m_WoolString = [[WoolString node] initWithStringFromSheep:self toNode:node];
    m_currentWool -= [m_WoolString findCurrentStringLength];
    [self addChild:m_WoolString];
}

- (void) breakString {
    if (m_WoolString) {
        [m_WoolString invalidate];
        [self removeChild:m_WoolString];
        m_WoolString = nil;
    }
}

-(void)setPowerup:(enum PowerupType)powerup {
    m_CurrentPowerup = powerup;

    if(powerup == puffBomb) {
        m_numPuffBombs++;
    } else if(powerup == shield) {
        [self schedule:@selector(blinkShield) interval: 7.0f];
    }
    
    [self schedule:@selector(cancelCurrentPowerup) interval:10.0f];
}

-(void)removePowerup {
    m_CurrentPowerup = NONE;
}

-(void) blinkShield {
    
}

-(void) cancelCurrentPowerup {
    m_CurrentPowerup = NONE;
}

- (void) update:(CCTime)delta {
    if(m_CurrentPowerup == shield) {
        [self drawDot:self.position radius:40 color:[CCColor lightGrayColor]];
    }
    m_WoolString.start = self.position;
    m_WoolString.end = m_AttachedNode.position;
}

@end
