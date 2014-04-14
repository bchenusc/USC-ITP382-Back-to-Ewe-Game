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
#import "CCTextureCache.h"

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
    
    /*// Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];*/
    
    // Background
    CGSize winSize = self.contentSize;
    /*
    CCSprite *background = [CCSprite spriteWithImageNamed:@"itp382ewe_title2_top.png"];
    background.position = ccp(winSize.width / 2, winSize.height*3/4);
    [background setBlendFunc:(ccBlendFunc){GL_ONE,GL_ZERO}];
    [self addChild:background];
    
    CCSprite *background2 = [CCSprite spriteWithImageNamed:@"itp382ewe_title2_bot.png"];
    background2.position = ccp(winSize.width / 2, winSize.height/4);
    [background2 setBlendFunc:(ccBlendFunc){GL_ONE,GL_ZERO}];
    [self addChild:background2];*/
    
    
    [CCTexture setDefaultAlphaPixelFormat:CCTexturePixelFormat_RGB565];
    
    CCSprite *background = [CCSprite spriteWithImageNamed:@"itp382ewe_title2.png"];
    //CCSprite *background = [CCSprite spriteWithImageNamed:@"Default.png"];
    background.position = ccp(winSize.width / 2, winSize.height/2);
    [background setBlendFunc:(ccBlendFunc){GL_ONE,GL_ZERO}];
    [self addChild:background];
    
    // Helloworld scene button
    CCButton *helloWorldButton = [CCButton buttonWithTitle:@"[ Start ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    helloWorldButton.positionType = CCPositionTypeNormalized;
    helloWorldButton.position = ccp(0.5f, 0.25f);
    [helloWorldButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:helloWorldButton];
    
    [[CCTextureCache sharedTextureCache] dumpCachedTextureInfo];
    
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[GameplayScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
