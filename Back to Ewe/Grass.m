//
//  Grass.m
//  Back to Ewe
//
//  Created by Jeffrey on 4/7/14.
//  Copyright (c) 2014 Silly Landmine Studios. All rights reserved.
//

#import "Grass.h"

@implementation Grass

@synthesize RCVAmount = m_rcvAmount;
@synthesize Radius = m_Radius;

- (instancetype)init
{
    self = [super init];
    if (self) {
        m_rcvAmount = 500.0f;
        
        //[self drawDot:ccp(0, 0) radius:m_Radius color:[CCColor greenColor]];
        
        CCSprite* sprite = [CCSprite spriteWithImageNamed:@"grass-2.png"];
        sprite.position = ccp(0, 0);
        [self addChild:sprite];
        
        m_Radius = max(sprite.contentSize.width / 2, sprite.contentSize.height / 2) * 0.75f;
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithCircleOfRadius:m_Radius andCenter:self.anchorPointInPoints];
        
        physics.elasticity = 4;
        physics.type = CCPhysicsBodyTypeStatic;
        physics.collisionCategories = @[@"grass"];
        physics.collisionMask = @[@"sheep"];
        physics.collisionType = @"grass";
        self.physicsBody = physics;
        
        physics.sensor = YES;
        
    }
    return self;
}

@end
