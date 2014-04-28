//
//  GameplayVariables.h
//  Back to Ewe
//
//  Created by administrator on 4/26/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

enum GameLevel {
    space = 0,
    jungle,
    TOTAL_LEVELS
};

@interface GameplayVariables : NSObject {
    enum GameLevel m_CurrentLevel;
}

@property enum GameLevel CurrentLevel;

+(GameplayVariables *)get;

-(void)switchCurrentLevel;

-(void)switchToLevel:(enum GameLevel)levelType;

@end
