//
//  Boss.m
//  Back to Ewe
//
//  Created by administrator on 4/13/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "Boss.h"
#import "CCActionInterval.h"
#import "GameplayVariables.h"


@implementation Boss

@synthesize BOSSTYPE = m_Boss;
@synthesize Radius = m_Radius;
@synthesize Health = m_Health;
@synthesize DamageFromSheep = m_DamageFromSheep;
@synthesize DamageFromProjectile = m_DamageFromProjectile;

- (instancetype)init {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        
        CCSprite* sprite;
        switch ([GameplayVariables get].CurrentLevel) {
            case space:
                sprite = [CCSprite spriteWithImageNamed:@"ewe_mothership.png"];
                sprite.position = ccp(0, 0);
                sprite.scale = 1.5;
                [self addChild:sprite];
                m_BossType = spaceBoss;
                break;
                
            case jungle:
                sprite = [CCSprite spriteWithImageNamed:@"ewe_gorilla.png"];
                sprite.position = ccp(0, 0);
                sprite.scale = 1.5;
                [self addChild:sprite];
                m_BossType = jungleBoss;
                break;
                
            default:
                break;
        }
        
        m_Radius = sprite.contentSize.width / 2 * 1.5;
        self.position = ccp(winSize.width / 2, winSize.height + m_Radius);
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithCircleOfRadius:m_Radius andCenter:self.anchorPointInPoints];
        
        physics.type = CCPhysicsBodyTypeStatic;
        physics.collisionCategories = @[@"boss"];
        physics.collisionMask = @[@"sheep", @"projectile"];
        physics.collisionType = @"boss";
        physics.sensor = YES;
        self.physicsBody = physics;
        
        m_Health = 100;
        m_DamageFromProjectile = 25;
        m_DamageFromSheep = 35;
        
        m_CanTakeDamage = YES;
    }
    return self;
}

-(void) setBossType {
    m_BossType = (enum BossType) (arc4random() % (int) BossTypeMax);
    switch(m_BossType) {
        case spaceBoss:
            break;
        default:
            break;
    }
}

-(void) hitBossWithSheep {
    if(m_CanTakeDamage) {
        m_CanTakeDamage = NO;
        m_Health -= m_DamageFromSheep;
        [self runAction:[CCActionBlink actionWithDuration:2.0f blinks:10]];
        [self scheduleOnce:@selector(enableDamage) delay:2.0f];
    }
}

-(void) hitBossWithProjectile {
    if(m_CanTakeDamage) {
        m_CanTakeDamage = NO;
        m_Health -= m_DamageFromProjectile;
        [self runAction:[CCActionBlink actionWithDuration:2.0f blinks:10]];
        [self scheduleOnce:@selector(enableDamage) delay:2.0f];
    }
}

-(void)enableDamage {
    m_CanTakeDamage = YES;
}

- (CGRect) rect {
    return CGRectMake(self.position.x - self.contentSize.width * self.anchorPoint.x,
                      self.position.y - self.contentSize.height * self.anchorPoint.y,
                      self.contentSize.width,
                      self.contentSize.height);
}

- (BOOL) isPointInBoss:(CGPoint)point {
    CGFloat distanceSqr = ccpDistanceSQ(point, self.position);
    CGFloat radiusSqr = m_Radius * m_Radius;
    
    return distanceSqr <= radiusSqr;
}

@end

