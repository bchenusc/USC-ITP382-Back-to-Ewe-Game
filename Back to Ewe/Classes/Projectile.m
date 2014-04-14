//
//  Projectile.m
//  Back to Ewe
//
//  Created by Jeffrey on 4/13/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "Projectile.h"


@implementation Projectile

@synthesize Target = m_Target;

- (instancetype)init
{
    self = [super init];
    if (self) {
        //Default never called
    }
    return self;
}

- (instancetype) initWithTarget:(CGPoint)projectileTarget atPosition:(CGPoint) initialPosition{
    self = [super init];
    if (self) {
        
        m_Speed = 0;
        self.position = initialPosition;
        m_Target = ccp((projectileTarget.x - initialPosition.x)*m_Speed, (projectileTarget.y - initialPosition.y)*m_Speed);
        
        CGPoint dirVector = ccpNormalize(ccpSub(projectileTarget, initialPosition));
        CGFloat angle = atanf(dirVector.x / dirVector.y) * 180.0 / M_PI;
        
        self.anchorPoint = ccp(0, 0);
        self.rotation = angle;
        
        CCSprite* sprite = [CCSprite spriteWithImageNamed:@"ewe_missile.png"];
        sprite.position = ccp(0, 0);
        [self addChild:sprite];
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithPillFrom:ccp(0, -sprite.contentSize.height * 3 / 8) to:ccp(0, sprite.contentSize.height * 3 / 8) cornerRadius:5];
        physics.type = CCPhysicsBodyTypeDynamic;
        physics.collisionCategories = @[@"projectile"];
        physics.collisionMask = @[@"enemy", @"wall"];
        physics.collisionType = @"projectile";
        physics.affectedByGravity = NO;
        
        self.physicsBody = physics;
        
        [self.physicsBody applyForce:m_Target];
    }
    return self;
}

@end
