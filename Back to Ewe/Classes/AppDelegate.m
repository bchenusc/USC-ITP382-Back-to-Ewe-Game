//
//  AppDelegate.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright Silly Landmine Studios 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "AppDelegate.h"
#import "MainMenuScene.h"
#import "GameplayScene.h"
#import "GameplayVariables.h"

// -----------------------------------------------------------------------
#define BACKGROUND_MUSIC @"bgmusic.mp3"

@implementation AppDelegate

// 
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// This is the only app delegate method you need to implement when inheriting from CCAppDelegate.
	// This method is a good place to add one time setup code that only runs when your app is first launched.
	
	// Setup Cocos2D with reasonable defaults for everything.
	// There are a number of simple options you can change.
	// If you want more flexibility, you can configure Cocos2D yourself instead of calling setupCocos2dWithOptions:.
	[self setupCocos2dWithOptions:@{
		// Show the FPS and draw call label.
		CCSetupShowDebugStats: @(YES),
		
		// More examples of options you might want to fiddle with:
		// (See CCAppDelegate.h for more information)
		
		// Use a 16 bit color buffer: 
//		CCSetupPixelFormat: kEAGLColorFormatRGB565,
		// Use a simplified coordinate system that is shared across devices.
		CCSetupScreenMode: CCScreenModeFlexible,
		// Run in portrait mode.
		CCSetupScreenOrientation: CCScreenOrientationPortrait,
		// Run at a reduced framerate.
//		CCSetupAnimationInterval: @(1.0/30.0),
		// Run the fixed timestep extra fast.
//		CCSetupFixedUpdateInterval: @(1.0/180.0),
		// Make iPad's act like they run at a 2x content scale. (iPad retina 4x)
//		CCSetupTabletScale2X: @(YES),
	}];
    
    // AUDIO
    [OALSimpleAudio sharedInstance].allowIpod = NO;
    [OALSimpleAudio sharedInstance].honorSilentSwitch = YES;
    [[OALSimpleAudio sharedInstance] preloadEffect:BACKGROUND_MUSIC];
    
    [[OALSimpleAudio sharedInstance] preloadEffect:BOING_SOUND];
    [[OALSimpleAudio sharedInstance] preloadEffect:SHEEP_HIT_SOUND];
    [[OALSimpleAudio sharedInstance] preloadEffect:SHEEP_DEATH_SOUND];
    [[OALSimpleAudio sharedInstance] preloadEffect:BOSS_HIT_SOUND];
    [[OALSimpleAudio sharedInstance] preloadEffect:BOSS_DEATH_SOUND];
    [[OALSimpleAudio sharedInstance] preloadEffect:POWERUP_SOUND];
    [[OALSimpleAudio sharedInstance] preloadEffect:BOMB_SOUND];
    [[OALSimpleAudio sharedInstance] preloadEffect:PROJECTILE_SOUND];
    [[OALSimpleAudio sharedInstance] preloadEffect:GAMEOVER_SOUND];
    [[OALSimpleAudio sharedInstance] preloadEffect:GET_GRASS_SOUND];
    [[OALSimpleAudio sharedInstance] preloadEffect:OUT_OF_WOOLF_SOUND];
    
    // SPRITES
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ewe-sprites.plist"];
	
	return YES;
}

-(CCScene *)startScene
{
	// This method should return the very first scene to be run when your app starts.
    // Sound

    [[OALSimpleAudio sharedInstance] playBg:BACKGROUND_MUSIC loop:YES];
    
	return [MainMenuScene scene];
}

@end
