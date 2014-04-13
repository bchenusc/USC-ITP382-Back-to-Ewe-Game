//
//  EnemyGenerator.h
//  Back to Ewe
//
//  Created by David Zhang on 04/07/14.
//  Copyright (c) 2014 Silly Landmine Studios. All rights reserved.
//

#import "EnemyGenerator.h"
#import "GameplayScene.h"

@implementation EnemyGenerator

- (id) init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
	return self;
}

-(Enemy*)spawnEnemy {
    Enemy* newEnemy = [Enemy node];
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    newEnemy.position = ccp(((float)(arc4random() % 100)) / 100 * (winSize.width - newEnemy.radius * 2) + newEnemy.radius, winSize.height + newEnemy.radius * 2);
    [newEnemy setRandomEnemyType];
    
    return newEnemy;
}

@end
