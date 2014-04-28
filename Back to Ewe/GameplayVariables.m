//
//  GameplayVariables.m
//  Back to Ewe
//
//  Created by administrator on 4/26/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "GameplayVariables.h"


@implementation GameplayVariables

+(GameplayVariables *)get {
    static dispatch_once_t once;
    static GameplayVariables* instance;
    dispatch_once(&once, ^{
        instance = [[GameplayVariables alloc] init];
    });
    return instance;
}

@synthesize CurrentLevel = m_CurrentLevel;

-(void)switchCurrentLevel {
    enum GameLevel previousLevel = m_CurrentLevel;
    while(previousLevel == m_CurrentLevel) {
        m_CurrentLevel = arc4random() % TOTAL_LEVELS;
    }
}

-(void)switchToLevel:(enum GameLevel)levelType {
    m_CurrentLevel = levelType;
}

@end
