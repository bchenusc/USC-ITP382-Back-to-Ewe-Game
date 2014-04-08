//
//  UILayer.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "UILayer.h"
#import "CCDrawingPrimitives.h"


@implementation UILayer

@synthesize Wool = m_woolRemaining;

- (instancetype)init
{
    self = [super init];
    if (self) {
        m_woolRemaining = 10000.0f;
        
        m_woolCapacity = 10000.0f;
    }
    return self;
}


- (void) draw {
    CGSize size = [[CCDirector sharedDirector] viewSize];
    
    ccDrawSolidRect(ccp(10,10), ccp((m_woolRemaining/m_woolCapacity)*(size.width - 10), 30), [CCColor blueColor]);
}

@end
