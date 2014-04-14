//
//  Powerup.m
//  Back to Ewe
//
//  Created by David Zhang on 4/12/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "Powerup.h"


@implementation Powerup

@synthesize radius = m_Radius;
@synthesize POWERUPTYPE = m_PowerupType;

- (instancetype)init {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        self.position = ccp(winSize.width / 2, winSize.height / 2);
        m_Radius = 18;
        
        m_Sprite = [CCSprite spriteWithImageNamed:@"shield_boost.png"];
        m_Sprite.position = ccp(0, 0);
        m_Sprite.scale = 0.55f;
        [self addChild:m_Sprite];
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithCircleOfRadius:m_Radius andCenter:self.anchorPointInPoints];
        physics.type = CCPhysicsBodyTypeStatic;
        physics.collisionCategories = @[@"powerup"];
        physics.collisionMask = @[@"sheep"];
        physics.collisionType = @"powerup";
        physics.sensor = YES;
        self.physicsBody = physics;
        
        m_PowerupType = NONE;
        
        m_PowerupLabel = [CCLabelTTF node];
        [m_PowerupLabel setFontName:@"Verdana"];
        [m_PowerupLabel setFontSize:10.0f];
        [m_PowerupLabel setPosition:ccp(0, 0)];
        [m_PowerupLabel setString:@"N"];
        [self addChild:m_PowerupLabel];
    }
    return self;
}

-(void) setRandomPowerupType {
    m_PowerupType = (enum PowerupType) (arc4random() % (int) powerupTypeMax);
    switch(m_PowerupType) {
        case shield:
            [m_PowerupLabel setString:@"S"];
            [self removeChild:m_Sprite];
            m_Sprite = [CCSprite spriteWithImageNamed:@"shield_boost.png"];
            m_Sprite.position = ccp(0, 0);
            m_Sprite.scale = 0.55f;
            [self addChild:m_Sprite];
            break;
        case unlimitedWool:
            [m_PowerupLabel setString:@"W"];
            [self removeChild:m_Sprite];
            m_Sprite = [CCSprite spriteWithImageNamed:@"puff_boost.png"];
            m_Sprite.position = ccp(0, 0);
            m_Sprite.scale = 0.55f;
            [self addChild:m_Sprite];
            break;
        case puffBomb:
            [m_PowerupLabel setString:@"B"];
            [self removeChild:m_Sprite];
            m_Sprite = [CCSprite spriteWithImageNamed:@"puff_bomb.png"];
            m_Sprite.position = ccp(0, 0);
            m_Sprite.scale = 0.55f;
            [self addChild:m_Sprite];
            break;
        case health:
            [m_PowerupLabel setString:@"H"];
            [self removeChild:m_Sprite];
            m_Sprite = [CCSprite spriteWithImageNamed:@"health_boost.png"];
            m_Sprite.position = ccp(0, 0);
            m_Sprite.scale = 0.55f;
            [self addChild:m_Sprite];
            break;
        case projectile:
            [m_PowerupLabel setString:@"P"];
            [self removeChild:m_Sprite];
            m_Sprite = [CCSprite spriteWithImageNamed:@"missile_boost.png"];
            m_Sprite.position = ccp(0, 0);
            m_Sprite.scale = 0.80f;
            [self addChild:m_Sprite];
            break;
        default:
            [m_PowerupLabel setString:@"N"];
            [self removeChild:m_Sprite];
            break;
    }
}

-(void) setProjectileType {
    m_PowerupType = projectile;
    [m_PowerupLabel setString:@"P"];
}

- (CGRect) rect {
    return CGRectMake(self.position.x - self.contentSize.width * self.anchorPoint.x,
                      self.position.y - self.contentSize.height * self.anchorPoint.y,
                      self.contentSize.width,
                      self.contentSize.height);
}

- (BOOL) isPointInPowerup:(CGPoint)point {
    CGFloat distanceSqr = ccpDistanceSQ(point, self.position);
    CGFloat radiusSqr = m_Radius * m_Radius;
    
    return distanceSqr <= radiusSqr;
}

@end
