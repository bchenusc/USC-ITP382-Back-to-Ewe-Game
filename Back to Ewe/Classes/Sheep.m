//
//  Sheep.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "Sheep.h"

@interface SheepPowerup : NSObject {
    CGFloat duration;
    CGFloat timeRemaining;
}

@property (readonly) enum PowerupType type;
@property (readonly) BOOL active;

- (instancetype) initWithType:(enum PowerupType)type;
- (void) activate;
- (void) activateWithDuration:(CGFloat)_duration;
- (void) deactivate;
- (void) reset;
- (void) update:(CCTime)dt;
@end

@implementation SheepPowerup
@synthesize type, active;

- (instancetype)init {
    self = [super init];
    if (self) {
        type = NONE;
        active = NO;
        duration = 8.0f;
        timeRemaining = duration;
    }
    return self;
}

- (instancetype) initWithType:(enum PowerupType)pType {
    type = pType;
    
    return self;
}

- (void) reset {
    active = NO;
    timeRemaining = 0;
}

- (void) activate {
    [self activateWithDuration:duration];
}

- (void) activateWithDuration:(CGFloat)_duration {
    active = YES;
    timeRemaining = _duration;
    
    //NSLog(@"%d activated", type);
}

- (void) deactivate {
    active = NO;
    timeRemaining = 0;
}

- (void) update:(CCTime)dt {
    if (active) {
        timeRemaining -= dt;
        
        if (timeRemaining <= 0) {
            timeRemaining = 0;
            active = NO;
            //NSLog(@"%d deactivated", type);
        }
    }
}

@end

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
        physics.collisionMask = @[@"enemy", @"projectile", @"border", @"node", @"grass", @"powerup", @"boss"];
        physics.collisionType = @"sheep";
        self.physicsBody = physics;
        
        m_WoolString = nil;
        m_AttachedNode = nil;
        
        m_maxWool = 4000;
        m_currentWool = m_maxWool;
        
        m_maxHealth = 100;
        m_currentHealth = m_maxHealth;
        
        m_CurrentPowerups = [NSMutableArray new];
        [m_CurrentPowerups addObject:[[[SheepPowerup alloc] init] initWithType:shield]];
        [m_CurrentPowerups addObject:[[[SheepPowerup alloc] init] initWithType:unlimitedWool]];
        
        m_numPuffBombs = 0;
    }
    return self;
}

- (bool) stringToNode:(Node*)node {
    NSAssert(node != nil, @"Argument must be non-nil");
    
    if (m_currentWool <= 0) {
        m_currentWool = 0;
        //NSLog(@"No wool");
        return NO;
    }
    
    m_AttachedNode = node;
    
    if (m_WoolString) {
        [m_WoolString invalidate];
        [self removeChild:m_WoolString];
        m_WoolString = nil;
    }
    
    m_WoolString = [[WoolString node] initWithStringFromSheep:self toNode:node];
    
    for (SheepPowerup* sp in m_CurrentPowerups) {
        if (sp.type == unlimitedWool) {
            if (!sp.active) {
                m_currentWool -= [m_WoolString findCurrentStringLength];
            }
            
            break;
        }
    }
    
    [self addChild:m_WoolString];
    
    return YES;
}

- (void) breakString {
    if (m_WoolString) {
        [m_WoolString invalidate];
        [self removeChild:m_WoolString];
        m_WoolString = nil;
        m_AttachedNode = nil;
    }
}

-(void) addPowerup:(enum PowerupType)powerup {
    for (SheepPowerup* sp in m_CurrentPowerups) {
        if (sp.type == powerup) {
            [sp activate];
            break;
        }
    }
}

-(BOOL) hitEnemy {
    for (SheepPowerup* sp in m_CurrentPowerups) {
        if (sp.type == shield) {
            if (!sp.active) {
                m_currentHealth -= 10.0f;
                [sp activateWithDuration:2.0f];
                [self runAction:[CCActionBlink actionWithDuration:2.0f blinks:10]];
                return YES;
            }
            
            break;
        }
    }
    
    return NO;
}

- (void) reset {
    for (SheepPowerup* sp in m_CurrentPowerups) {
        [sp deactivate];
    }
}

- (void) update:(CCTime)delta {
    m_WoolString.start = self.position;
    m_WoolString.end = m_AttachedNode.position;
    
    for (SheepPowerup* sp in m_CurrentPowerups) {
        [sp update:delta];
    }
}

-(void) spinIntoCenter {
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    
    self.physicsBody.sensor = YES;
    self.physicsBody.velocity = ccp(0,0);
    self.physicsBody.force = ccp(0, 0);
    self.physicsBody.affectedByGravity = NO;
    [self.physicsBody applyForce:ccp(0, 10000)];
    
    if (m_WoolString) {
        [m_WoolString invalidate];
        [self removeChild:m_WoolString];
        m_WoolString = nil;
    }
    
    [self runAction:[CCActionMoveTo actionWithDuration:3.0f position:ccp(viewSize.width / 2, viewSize.height / 2)]];
    [self runAction:[CCActionRotateBy actionWithDuration:3.0f angle:1080]];
    [self runAction:[CCActionScaleTo actionWithDuration:3.0f scale:0.0f]];
    [self scheduleOnce:@selector(doneTeleporting) delay:3.2f];
}

-(void) doneTeleporting {
    self.physicsBody.sensor = NO;
    self.physicsBody.affectedByGravity = YES;
    self.scale = 1.0f;
}

@end
