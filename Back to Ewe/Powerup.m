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
        m_Radius = 10;
        
        [self drawDot:ccp(0, 0) radius:m_Radius color:[CCColor orangeColor]];
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithCircleOfRadius:m_Radius andCenter:self.anchorPointInPoints];
        physics.type = CCPhysicsBodyTypeStatic;
        physics.collisionCategories = @[@"powerup"];
        physics.collisionMask = @[@"sheep"];
        physics.collisionType = @"powerup";
        physics.sensor = YES;
        self.physicsBody = physics;
        
        m_PowerupType = shield;
    }
    return self;
}

-(void) setRandomPowerupType {
    m_PowerupType = (enum PowerupType) (arc4random() % (int) powerupTypeMax);
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
