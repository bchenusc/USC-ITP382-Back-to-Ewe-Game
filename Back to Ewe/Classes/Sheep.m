//
//  Sheep.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "Sheep.h"


@implementation Sheep

- (instancetype)init {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        self.position = ccp(winSize.width / 2, 60);
        [self drawDot:ccp(0, 0) radius:30 color:[CCColor blueColor]];
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithCircleOfRadius:30 andCenter:self.anchorPointInPoints];
        physics.elasticity = 4;
        physics.type = CCPhysicsBodyTypeDynamic;
        physics.collisionCategories = @[@"sheep"];
        physics.collisionMask = @[@"node"];
        physics.collisionType = @"sheep";
        self.physicsBody = physics;
        
        m_WoolString = nil;
        m_AttachedNode = nil;
    }
    return self;
}

- (void) stringToNode:(Node*)node {
    m_AttachedNode = node;
    
    if (m_WoolString) {
        [m_WoolString invalidate];
        [self removeChild:m_WoolString];
        m_WoolString = nil;
    }
    
    m_WoolString = [[WoolString node] initWithStringFromSheep:self toNode:node];
    [self addChild:m_WoolString];
}

- (void) update:(CCTime)delta {
    m_WoolString.start = self.position;
    m_WoolString.end = m_AttachedNode.position;
}

@end
