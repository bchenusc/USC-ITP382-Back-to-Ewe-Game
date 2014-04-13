//
//  EnemyGenerator.h
//  Back to Ewe
//
//  Created by David Zhang on 04/07/14.
//  Copyright (c) 2014 Silly Landmine Studios. All rights reserved.
//

#import "cocos2d.h"
#import "Enemy.h"

@interface EnemyGenerator : CCNode
{
    int roundNum;   //every 10 waves is a round.
    int waveNum;    //every pattern is 1 wave.
}

-(Enemy*)spawnEnemy;

@end
