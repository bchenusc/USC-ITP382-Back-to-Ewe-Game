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
#import "MainMenuScene.h"
#import "GameplayScene.h"


@implementation UILayer

@synthesize Wool = m_woolRemaining;
@synthesize Health = m_healthRemaining;
@synthesize Score = m_Score;
@synthesize Lives = m_Lives;

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGSize size = [[CCDirector sharedDirector] viewSize];
        self.contentSize = size;
        
        m_woolRemaining = 10000.0f;
        m_woolCapacity = 10000.0f;
        
        m_healthRemaining = 100.0f;
        m_healthCapacity = 100.0f;
        
        m_Score = 0;
        m_scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score: %.f", m_Score] fontName:@"Verdana-Bold" fontSize:18.0f];
        m_scoreLabel.horizontalAlignment = CCTextAlignmentLeft;
        m_scoreLabel.positionType = CCPositionTypeNormalized;
        m_scoreLabel.position = ccp(0.15f, 0.98f);
        [self addChild:m_scoreLabel];
        
        m_Lives = 0;
        m_livesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Lives: %d", m_Lives] fontName:@"Verdana-Bold" fontSize:18.0f];
        m_livesLabel.positionType = CCPositionTypeNormalized;
        m_livesLabel.position = ccp(0.15f, 0.95f);
        [self addChild:m_livesLabel];
        
        // Game Over label
        m_GameOverLabel = [CCLabelTTF labelWithString:@"Game Over!" fontName:@"Marker Felt" fontSize:36.0f ];
        m_GameOverLabel.visible = NO;
        m_GameOverLabel.positionType = CCPositionTypeNormalized;
        m_GameOverLabel.position = ccp(0.5f, 0.6f);
        [self addChild:m_GameOverLabel];
        
        // Pause button
        m_PauseButton = [CCButton buttonWithTitle:@"[ Pause ]" fontName:@"Verdana-Bold" fontSize:18.0f];
        m_PauseButton.positionType = CCPositionTypeNormalized;
        m_PauseButton.position = ccp(0.85f, 0.98f);
        [m_PauseButton setTarget:self selector:@selector(onPauseClicked:)];
        [self addChild:m_PauseButton];
        
        // New game button
        m_NewGameButton = [CCButton buttonWithTitle:@"[ New Game ]" fontName:@"Verdana-Bold" fontSize:18.0f];
        m_NewGameButton.positionType = CCPositionTypeNormalized;
        m_NewGameButton.position = ccp(0.25f, 0.5f); // Middle Left of screen
        [m_NewGameButton setTarget:self selector:@selector(onNewGameClicked:)];
        [self addChild:m_NewGameButton];
        m_NewGameButton.visible = NO;
        
        // Menu Button
        m_MainMenuButton = [CCButton buttonWithTitle:@"[ Main Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
        m_MainMenuButton.positionType = CCPositionTypeNormalized;
        m_MainMenuButton.position = ccp(0.75f, 0.5f); // Middle Right of screen
        [m_MainMenuButton setTarget:self selector:@selector(onMainMenuClicked:)];
        [self addChild:m_MainMenuButton];
        m_MainMenuButton.visible = NO;
        
        // Resume button
        m_ResumeButton = [CCButton buttonWithTitle:@"[ Resume ]" fontName:@"Verdana-Bold" fontSize:18.0f];
        m_ResumeButton.positionType = CCPositionTypeNormalized;
        m_ResumeButton.position = ccp(0.5f, 0.4f); // Middle Right of screen
        [m_ResumeButton setTarget:self selector:@selector(onResumeClicked:)];
        [self addChild:m_ResumeButton];
        m_ResumeButton.visible = NO;
    }
    return self;
}

- (void) setGameplayScene:(GameplayScene*)g {
    NSAssert(g != nil, @"Argument must be non nil.");
    
    m_gameplayScene = g;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void) onPauseClicked:(id)sender {
    m_PauseButton.visible = NO;
    m_NewGameButton.visible = YES;
    m_MainMenuButton.visible = YES;
    m_ResumeButton.visible = YES;
    [m_gameplayScene pause];
}

- (void) onNewGameClicked:(id)sender {
    [m_gameplayScene resetGame];
}

- (void) onMainMenuClicked:(id)sender {
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

- (void) onResumeClicked:(id)sender {
    m_PauseButton.visible = YES;
    m_NewGameButton.visible = NO;
    m_MainMenuButton.visible = NO;
    m_ResumeButton.visible = NO;
    m_gameplayScene.paused = NO;
    [m_gameplayScene resume];
}

// -----------------------------------------------------------------------

- (void) reset {
    m_PauseButton.visible = YES;
    m_NewGameButton.visible = NO;
    m_MainMenuButton.visible = NO;
    m_ResumeButton.visible = NO;
    m_gameplayScene.paused = NO;
    
    m_GameOverLabel.visible = NO;
}

- (void) gameOver {
    m_GameOverLabel.visible = YES;
    
    m_PauseButton.visible = NO;
    m_NewGameButton.visible = YES;
    m_MainMenuButton.visible = YES;
    m_ResumeButton.visible = NO;
    [m_gameplayScene pause];
}

- (void) draw {
    CGSize size = [[CCDirector sharedDirector] viewSize];
    
    ccDrawSolidRect(ccp(0, 0), ccp((m_woolRemaining/m_woolCapacity)*(size.width), 10), [CCColor greenColor]);
    
    ccDrawSolidRect(ccp(0, 10), ccp((m_healthRemaining/m_healthCapacity)*(size.width), 20), [CCColor redColor]);
    
    [m_scoreLabel setString:[NSString stringWithFormat:@"Score: %.f", m_Score]];
    
    [m_livesLabel setString:[NSString stringWithFormat:@"Lives: %i", m_Lives]];
    
}

@end
