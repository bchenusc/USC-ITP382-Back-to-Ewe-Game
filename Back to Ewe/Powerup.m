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
    m_PowerupType = puffBomb;
    switch(m_PowerupType) {
        case shield:
            [m_PowerupLabel setString:@"S"];
            break;
        case unlimitedWool:
            [m_PowerupLabel setString:@"W"];
            break;
        case puffBomb:
            [m_PowerupLabel setString:@"B"];
            break;
        case health:
            [m_PowerupLabel setString:@"H"];
            break;
        default:
            [m_PowerupLabel setString:@"N"];
            break;
    }
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
