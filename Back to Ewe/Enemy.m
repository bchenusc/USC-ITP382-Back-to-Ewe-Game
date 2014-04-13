//
//  Enemy.m
//  Back to Ewe
//
//  Created by David Zhang on 4/7/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "Enemy.h"
#import "chipmunk_unsafe.h"

@implementation Enemy

@synthesize radius = m_Radius;
@synthesize ENEMYTYPE = m_EnemyType;

- (instancetype)init {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        self.position = ccp(winSize.width / 2, winSize.height / 2);
        m_Radius = 20;
        m_OriginalRadius = 20;
        [self drawDot:ccp(0, 0) radius:m_Radius color:[CCColor purpleColor]];
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithCircleOfRadius:m_Radius andCenter:self.anchorPointInPoints];
        physics.type = CCPhysicsBodyTypeStatic;
        physics.collisionCategories = @[@"enemy"];
        physics.collisionMask = @[@"sheep"];
        physics.collisionType = @"enemy";
        physics.sensor = YES;
        self.physicsBody = physics;
        
        m_EnemyType = stationary;
        m_CenterPosition = self.position;
        m_MovementBounds = 0;
        m_MovementSpeed = 0;
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

-(void) setRandomEnemyType {
    m_EnemyType = (enum EnemyType) (arc4random() % (int) EnemyTypeMax);
    m_EnemyType = expander;
    NSLog(@"Enemytype:%u", m_EnemyType);
    switch(m_EnemyType) {
            case horizontalMover:
            m_CenterPosition = self.position;
            m_MovementSpeed = m_Radius * 4;
            m_MovementBounds = m_Radius;
            break;
            case verticalMover:
            m_CenterPosition = self.position;
            m_MovementSpeed = m_Radius * 4;
            m_MovementBounds = m_Radius;
            break;
            case stationary:
            m_CenterPosition = self.position;
            m_MovementSpeed = 0;
            m_MovementBounds = 0;
            break;
            case expander:
            m_CenterPosition = self.position;
            m_MovementSpeed = m_Radius;
            m_MovementBounds = m_Radius * 2;
        default:
            break;
    }
}

-(void)setPositionAndCenter:(CGPoint)point {
    self.position = point;
    m_CenterPosition = point;
}

-(void)update:(CCTime)delta {
    
    switch(m_EnemyType) {
        case horizontalMover:
            self.position = ccp(self.position.x + m_MovementSpeed * delta, self.position.y);
            if(fabsf(m_CenterPosition.x - self.position.x) > m_MovementBounds) {
                if(self.position.x < m_CenterPosition.x - m_MovementBounds) {
                    self.position = ccp(m_CenterPosition.x - m_MovementBounds, m_CenterPosition.y);
                }
                if(self.position.x > m_CenterPosition.x + m_MovementBounds) {
                    self.position = ccp(m_CenterPosition.x + m_MovementBounds, m_CenterPosition.y);
                }
                m_MovementSpeed *= -1;
            }
            break;
        case verticalMover:
            self.position = ccp(self.position.x, self.position.y + m_MovementSpeed * delta);
            if(fabsf(m_CenterPosition.y - self.position.y) > m_MovementBounds) {
                if(self.position.y < m_CenterPosition.y - m_MovementBounds) {
                    self.position = ccp(m_CenterPosition.x, m_CenterPosition.y - m_MovementBounds);
                }
                if(self.position.y > m_CenterPosition.y + m_MovementBounds) {
                    self.position = ccp(m_CenterPosition.x, m_CenterPosition.y + m_MovementBounds);
                }
                m_MovementSpeed *= -1;
            }
            break;
        case expander:
            m_Radius += m_MovementSpeed * delta;
            self.scale = m_Radius / m_OriginalRadius;
            cpCircleShapeSetRadius(self, m_Radius);
            if(m_Radius >= m_MovementBounds) {
                m_Radius = m_MovementBounds;
                m_MovementSpeed *= -1;
            }
            if(m_Radius <= m_OriginalRadius) {
                m_Radius = m_OriginalRadius;
                m_MovementSpeed *= -1;
            }
        default:
            break;
    }
}

@end
