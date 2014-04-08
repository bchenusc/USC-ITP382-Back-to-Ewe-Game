//
//  Enemy.m
//  Back to Ewe
//
//  Created by David Zhang on 4/7/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "Enemy.h"


@implementation Enemy

@synthesize radius = m_Radius;

- (instancetype)init {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        self.position = ccp(winSize.width / 2, winSize.height / 2);
        m_Radius = 20;
        [self drawDot:ccp(0, 0) radius:m_Radius color:[CCColor purpleColor]];
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithCircleOfRadius:m_Radius andCenter:self.anchorPointInPoints];
        physics.type = CCPhysicsBodyTypeStatic;
        physics.collisionCategories = @[@"enemy"];
        physics.collisionMask = @[@"sheep"];
        physics.collisionType = @"enemy";
        physics.sensor = YES;
        self.physicsBody = physics;
    }
    return self;
}

- (CGRect) rect {
    return CGRectMake(self.position.x - self.contentSize.width * self.anchorPoint.x,
                      self.position.y - self.contentSize.height * self.anchorPoint.y,
                      self.contentSize.width,
                      self.contentSize.height);
}

- (BOOL) isPointInEnemy:(CGPoint)point {
    CGFloat distanceSqr = ccpDistanceSQ(point, self.position);
    CGFloat radiusSqr = m_Radius * m_Radius;
    
    return distanceSqr <= radiusSqr;
}

@end
