//
//  Boss.m
//  Back to Ewe
//
//  Created by administrator on 4/13/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "Boss.h"
#import "CCActionInterval.h"


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
        self.position = ccp(winSize.width / 2, winSize.height);
        
        m_Radius = winSize.width / 2;
        [self drawDot:ccp(0, 0) radius:m_Radius color:[CCColor yellowColor]];
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithRect:CGRectMake(-m_Radius, -m_Radius, m_Radius, 0) cornerRadius:0.0f];
        
        physics.type = CCPhysicsBodyTypeStatic;
        physics.collisionCategories = @[@"boss"];
        physics.collisionMask = @[@"sheep", @"projectile"];
        physics.collisionType = @"boss";
        physics.sensor = YES;
        self.physicsBody = physics;
        
        m_BossType = spaceBoss;
        
        m_Health = 100;
        m_DamageFromProjectile = 15;
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

