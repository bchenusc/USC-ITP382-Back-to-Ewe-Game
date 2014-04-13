//
//  NodePattern.h
//  Back to Ewe
//
//  Created by Brian Chen on 3/31/14.
//  Copyright (c) 2014 Silly Landmine Studios. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "GameplayScene.h"

@interface NodePattern : CCNode{
    GameplayScene* gameplayScene;
    CGSize winSize;
    CGPoint topNodePosition;
    CGPoint scrollPosition;
}

- (CGPoint) ChoosePattern: (int) waveNum : (GameplayScene*) gameplayScene;
- (CGPoint) ChooseRandomPattern: (int) waveNum : (GameplayScene*) gameScene;
@end
