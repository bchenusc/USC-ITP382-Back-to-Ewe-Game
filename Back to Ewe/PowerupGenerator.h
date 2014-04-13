//
//  PowerupGenerator.h
//  Back to Ewe
//
//  Created by David Zhang on 4/12/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Powerup.h"

@interface PowerupGenerator : CCNode
{
}

-(Powerup*)spawnPowerup;

@end