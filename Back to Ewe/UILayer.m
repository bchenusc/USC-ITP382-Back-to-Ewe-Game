//
//  UILayer.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "UILayer.h"
#import "CCDrawingPrimitives.h"
#import "CCLabelTTF.h"


@implementation UILayer

@synthesize Wool = m_woolRemaining;
@synthesize Health = m_healthRemaining;
@synthesize Score = m_Score;

- (instancetype)init
{
    self = [super init];
    if (self) {
        m_woolRemaining = 10000.0f;
        m_woolCapacity = 10000.0f;
        
        m_healthRemaining = 100.0f;
        m_healthCapacity = 100.0f;
        
        m_Score = 0;
        m_scoreLabel = [CCLabelTTF node];
        [m_scoreLabel setFontName:@"Verdana-Bold"];
        [m_scoreLabel setFontSize:18.0f];
        [m_scoreLabel setHorizontalAlignment:CCTextAlignmentLeft];
        [self addChild:m_scoreLabel];
    }
    return self;
}


- (void) draw {
    CGSize size = [[CCDirector sharedDirector] viewSize];
    
    ccDrawSolidRect(ccp(0, 0), ccp((m_woolRemaining/m_woolCapacity)*(size.width), 10), [CCColor greenColor]);
    
    ccDrawSolidRect(ccp(0, 10), ccp((m_healthRemaining/m_healthCapacity)*(size.width), 20), [CCColor redColor]);
    
    [m_scoreLabel setString:[NSString stringWithFormat:@"Score: %d", m_Score]];
    
            [m_scoreLabel setPosition:ccp(m_scoreLabel.texture.contentSize.width / 2, size.height - m_scoreLabel.texture.contentSize.height / 2)];
}

@end
