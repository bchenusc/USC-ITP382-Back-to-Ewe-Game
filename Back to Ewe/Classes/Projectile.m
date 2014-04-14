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
        m_Target = projectileTarget;
        
        self.position = initialPosition;
        
        
        [self drawDot:ccp(0, 0) radius:10 color:[CCColor purpleColor]];
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithCircleOfRadius:10.0f andCenter:self.anchorPointInPoints];
        physics.type = CCPhysicsBodyTypeDynamic;
        physics.collisionCategories = @[@"projectile"];
        physics.collisionMask = @[@"enemy"];
        
        self.physicsBody = physics;
        
        [physics applyForce:m_Target];
    }
    return self;
}

@end
