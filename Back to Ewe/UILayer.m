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
@synthesize Lives = m_Lives;

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
        
        m_Lives = 0;
        m_livesLabel = [CCLabelTTF labelWithString:@"n/a" fontName:@"Verdana-Bold" fontSize:18.0f];
        [m_livesLabel setHorizontalAlignment:CCTextAlignmentLeft];
        [self addChild:m_livesLabel];
        
        m_GameOverLabel = [CCLabelTTF labelWithString:@"Game Over!" fontName:@"Marker Felt" fontSize:36.0f ];
        m_GameOverLabel.visible = NO;
        [self addChild:m_GameOverLabel];
        
    }
    return self;
}

- (void) showGameOverLabel:(BOOL)choice {
    m_GameOverLabel.visible = choice;
}

- (void) draw {
    CGSize size = [[CCDirector sharedDirector] viewSize];
    
    ccDrawSolidRect(ccp(0, 0), ccp((m_woolRemaining/m_woolCapacity)*(size.width), 10), [CCColor greenColor]);
    
    ccDrawSolidRect(ccp(0, 10), ccp((m_healthRemaining/m_healthCapacity)*(size.width), 20), [CCColor redColor]);
    
    [m_scoreLabel setString:[NSString stringWithFormat:@"Score: %.f", m_Score]];
    
            [m_scoreLabel setPosition:ccp(m_scoreLabel.texture.contentSize.width / 2, size.height - m_scoreLabel.texture.contentSize.height / 2)];
    
    [m_livesLabel setString:[NSString stringWithFormat:@"Lives: %i", m_Lives]];
    [m_livesLabel setPosition:ccp(m_livesLabel.texture.contentSize.width / 2, size.height - m_livesLabel.texture.contentSize.height - m_scoreLabel.texture.contentSize.height / 2)];
    
}

@end
