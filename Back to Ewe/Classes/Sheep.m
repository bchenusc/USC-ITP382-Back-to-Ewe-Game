//
//  Sheep.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "Sheep.h"


@implementation Sheep

@synthesize attachedNode = m_AttachedNode;
@synthesize CurrentWool = m_currentWool;
@synthesize MaxWool = m_maxWool;
@synthesize CurrentHealth = m_currentHealth;
@synthesize MaxHealth = m_maxHealth;
@synthesize CurrentPowerups = m_CurrentPowerups;

- (instancetype)init {
    self = [super initWithImageNamed:@"itp382sheep.png"];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        self.position = ccp(winSize.width / 2, 60);
        
        CGFloat _radius = powf(powf(self.contentSize.width, 2) + powf(self.contentSize.height, 2), 0.5f) / 2 * 0.9f;
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithCircleOfRadius:_radius andCenter:self.anchorPointInPoints];
        physics.type = CCPhysicsBodyTypeDynamic;
        physics.collisionCategories = @[@"sheep"];
        physics.collisionMask = @[@"enemy", @"projectile", @"border", @"node", @"grass", @"powerup"];
        physics.collisionType = @"sheep";
        self.physicsBody = physics;
        
        m_WoolString = nil;
        m_AttachedNode = nil;
        
        m_maxWool = 10000.0f;
        m_currentWool = m_maxWool;
        
        m_maxHealth = 100;
        m_currentHealth = 100;
        
        m_CurrentPowerups = [NSMutableArray new];
        
        m_numPuffBombs = 0;
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
    
    if([m_CurrentPowerups indexOfObject:[NSNumber numberWithInt:unlimitedWool]] == NSNotFound) {
        m_currentWool -= [m_WoolString findCurrentStringLength];
    }
    [self addChild:m_WoolString];
}

- (void) breakString {
    if (m_WoolString) {
        [m_WoolString invalidate];
        [self removeChild:m_WoolString];
        m_WoolString = nil;
        m_AttachedNode = nil;
    }
}

-(void)addPowerup:(enum PowerupType)powerup {
    if(powerup == shield || powerup == unlimitedWool) {
        [m_CurrentPowerups addObject:[NSNumber numberWithInt:powerup]];
        [self scheduleOnce:@selector(cancelOldestPowerup) delay:10.0f];
    }
}

-(void) cancelOldestPowerup {
    if(m_CurrentPowerups.count != 0) {
        [m_CurrentPowerups removeObjectAtIndex:0];
    }
}

- (void) update:(CCTime)delta {
    m_WoolString.start = self.position;
    m_WoolString.end = m_AttachedNode.position;
}

@end
