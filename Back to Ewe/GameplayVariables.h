//
//  GameplayVariables.h
//  Back to Ewe
//
//  Created by administrator on 4/26/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BACKGROUND_MUSIC @"bgmusic.mp3"
#define BOING_SOUND @"boing.mp3"
#define SHEEP_HIT_SOUND @"sheepHit.mp3"
#define SHEEP_DEATH_SOUND @"sheepDeath.mp3"
#define BOSS_HIT_SOUND @"bossHit.mp3"
#define BOSS_DEATH_SOUND @"bossDeath.mp3"
#define POWERUP_SOUND @"powerup.mp3"
#define BOMB_SOUND @"bomb.mp3"
#define PROJECTILE_SOUND @"projectile.mp3"
#define GAMEOVER_SOUND @"gameOver.mp3"
#define GET_GRASS_SOUND @"getGrass.mp3"
#define OUT_OF_WOOLF_SOUND @"Blip_Select115.wav"

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
