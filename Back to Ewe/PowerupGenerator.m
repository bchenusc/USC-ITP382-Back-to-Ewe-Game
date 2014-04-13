//
//  PowerupGenerator.m
//  Back to Ewe
//
//  Created by David Zhang on 4/12/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "PowerupGenerator.h"
#import "GameplayScene.h"

@implementation PowerupGenerator

- (id) init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
	return self;
}

-(Powerup*) spawnPowerup {
    Powerup* newPowerup = [Powerup node];
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    newPowerup.position = ccp(((float)(arc4random() % 100)) / 100 * (winSize.width - newPowerup.radius * 2) + newPowerup.radius, winSize.height + newPowerup.radius * 2);
    [newPowerup setRandomPowerupType];
    
    return newPowerup;
}

@end
