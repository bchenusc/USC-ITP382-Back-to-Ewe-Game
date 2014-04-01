//
//  Node.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "Node.h"


@implementation Node

- (instancetype)init {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        self.position = ccp(winSize.width / 2, winSize.height - winSize.height / 15);
        [self drawDot:ccp(0, 0) radius:30 color:[CCColor redColor]];
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithCircleOfRadius:30 andCenter:self.anchorPointInPoints];
        physics.type = CCPhysicsBodyTypeStatic;
        physics.collisionCategories = @[@"node"];
        physics.collisionMask = @[@"sheep"];
        physics.collisionType = @"node";
        self.physicsBody = physics;
    }
    return self;
}

@end
