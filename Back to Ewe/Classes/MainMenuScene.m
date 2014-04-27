//
//  MainMenuScene.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright Silly Landmine Studios 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "MainMenuScene.h"
#import "GameplayScene.h"
#import "HighScoresScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation MainMenuScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (MainMenuScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Background
    CGSize winSize = self.contentSize;
    CCSprite *background = [CCSprite spriteWithImageNamed:@"itp382ewe_title2.png"];
    background.position = ccp(winSize.width / 2, winSize.height/2);
    [background setBlendFunc:(ccBlendFunc){GL_ONE,GL_ZERO}];
    [self addChild:background];
    
    // Play game button
    CCButton *playGameButton = [CCButton buttonWithTitle:@"[ Start ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    playGameButton.positionType = CCPositionTypeNormalized;
    playGameButton.position = ccp(0.5f, 0.25f);
    [playGameButton setTarget:self selector:@selector(onStartClicked:)];
    [self addChild:playGameButton];
    
    // High score button
    CCButton *highScoreButton = [CCButton buttonWithTitle:@"[ High Scores ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    highScoreButton.positionType = CCPositionTypeNormalized;
    highScoreButton.position = ccp(0.5f, 0.1f);
    [highScoreButton setTarget:self selector:@selector(onScoresClicked:)];
    [self addChild:highScoreButton];
    
    
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onStartClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[GameplayScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
}

-(void)onScoresClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[HighScoresScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
