//
//  HighScoresLayer.m
//  Back to Ewe
//
//  Created by administrator on 4/21/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "HighScoresScene.h"
#import "MainMenuScene.h"


@implementation HighScoresScene

+ (HighScoresScene *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Background
    CGSize winSize = self.contentSize;
    CCSprite *background = [CCSprite spriteWithImageNamed:@"itp382ewe_bg.png"];
    background.position = ccp(winSize.width / 2, winSize.height/2);
    [background setBlendFunc:(ccBlendFunc){GL_ONE,GL_ZERO}];
    [self addChild:background];
    
    // Back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Back ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.5f, 0.1f);
    [backButton setTarget:self selector:@selector(onBackButtonClicked:)];
    [self addChild:backButton];
    
    m_HighScoresList = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* defaultScores = [NSMutableDictionary new];
    for(int i = 1; i <= 10; i++) {
        [defaultScores setValue:0 forKey:[NSString stringWithFormat:@"%d", i]];
    }
    
    CCLabelTTF* highScoresTitle = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"HIGH SCORES"] fontName:@"Verdana-Bold" fontSize:16.0f];
    highScoresTitle.horizontalAlignment = CCTextAlignmentCenter;
    highScoresTitle.positionType = CCPositionTypeNormalized;
    highScoresTitle.position = ccp(0.5f, 0.9f);
    [self addChild:highScoresTitle];
    
    // Scores
    for(int i = 1; i <= 10; i++) {
        long int currentHighScore = [m_HighScoresList integerForKey:[NSString stringWithFormat:@"%d", i]];
        CCLabelTTF* currentHighScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%u: %ld", i, currentHighScore] fontName:@"Verdana-Bold" fontSize:16.0f];
        currentHighScoreLabel.horizontalAlignment = CCTextAlignmentLeft;
        currentHighScoreLabel.positionType = CCPositionTypeNormalized;
        currentHighScoreLabel.position = ccp(0.5f, 1.0f - ((float)i) / 15.0f - 0.1f);
        [self addChild:currentHighScoreLabel];
    }
    
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackButtonClicked:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionDown duration:1.0f]];
}

// -----------------------------------------------------------------------
-(void)addScore:(int)score {
    for(int i = 1; i <= 10; i++) {
        long int currentHighScore = [m_HighScoresList integerForKey:[NSString stringWithFormat:@"%d", i]];
        if(score > currentHighScore) {
            for(int j = 9; j >= i; j--) {
                long int previousScore = [m_HighScoresList integerForKey:[NSString stringWithFormat:@"%d", j]];
                [m_HighScoresList setInteger:previousScore forKey:[NSString stringWithFormat:@"%d", j + 1]];
            }
            [m_HighScoresList setInteger:score forKey:[NSString stringWithFormat:@"%d", i]];
            break;
        }
    }
}

@end
