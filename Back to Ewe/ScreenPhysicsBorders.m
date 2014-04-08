//
//  ScreenPhysicsBorders.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 4/7/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "ScreenPhysicsBorders.h"


@implementation ScreenPhysicsBorders

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        CGFloat w = winSize.width;      // Window width
        CGFloat h = winSize.height;     // Window height
        CGFloat o = 8;                  // Offset bounds
        
        CCPhysicsBody* physics = [CCPhysicsBody bodyWithShapes:@[[CCPhysicsShape rectShape:CGRectMake(-o, 0, o, h) cornerRadius:0],     // Left bounding box
                                                                 [CCPhysicsShape rectShape:CGRectMake(w, 0, w+o, h) cornerRadius:0],    // Right bounding box
                                                                 [CCPhysicsShape rectShape:CGRectMake(0, h, w, h+o) cornerRadius:0],    // Top bounding box
                                                               /*[CCPhysicsShape rectShape:CGRectMake(0, -o, w, 0) cornerRadius:0]*/]]; // Bottom bounding box
        physics.type = CCPhysicsBodyTypeStatic;
        physics.elasticity = 0.25f;
        physics.friction = 0;
        physics.collisionType = @"border";
        self.physicsBody = physics;
    }
    return self;
}

@end
