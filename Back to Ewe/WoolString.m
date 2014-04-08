//
//  WoolString.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "WoolString.h"
#import "CCDrawingPrimitives.h"
#import "Sheep.h"
#import "Node.h"


@implementation WoolString

@synthesize start = m_Start, end = m_End, width = m_Width;

- (instancetype) init {
    self = [super init];
    if (self) {
        self.position = ccp(0, 0);
        m_Start = ccp(0, 0);
        m_End = ccp(0, 0);
        m_Width = 6.5f;
        
        m_Joint = nil;
    }
    return self;
}

- (instancetype) initWithStringFromSheep:(Sheep*)sheep toNode:(Node*)node {
    NSAssert(sheep != nil, @"Argument must be non-nil");
    NSAssert(node != nil, @"Argument must be non-nil");
    
    m_Start = sheep.position;
    m_End = node.position;
    
    m_Joint = [CCPhysicsJoint connectedSpringJointWithBodyA:sheep.physicsBody
                                                      bodyB:node.physicsBody
                                                    anchorA:ccp(0, 0)
                                                    anchorB:ccp(0, 0)
                                                 restLength:30.0f
                                                  stiffness:20.00f
                                                    damping:4.25f];
    
    return self;
}

- (void) invalidate {
    [m_Joint invalidate];
}

+ (float) findStringLengthFromSheep:(Sheep*)sheep toNode:(Node*) node {
    NSAssert(sheep != nil, @"Argument must be non-nil");
    NSAssert(node != nil, @"Argument must be non-nil");
    
    return ccpDistance(sheep.position, node.position);
}

- (float) findCurrentStringLength {
    return sqrtf(m_Start.x*m_Start.x + m_Start.y*m_Start.y);
}

- (void) draw {
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    ccDrawColor4F(1, 1, 1, 1);
    glLineWidth(m_Width);
    
    CGPoint t_start = ccp(m_Start.x, winSize.height - m_Start.y);
    CGPoint t_end = ccp(m_End.x, winSize.height - m_End.y);
    ccDrawLine([[CCDirector sharedDirector] convertToGL: t_start], [[CCDirector sharedDirector] convertToGL: t_end]);
}

@end
