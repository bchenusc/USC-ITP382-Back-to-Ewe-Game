//
//  NodeGenerator.m
//  Back to Ewe
//
//  Created by Brian Chen on 3/31/14.
//  Copyright (c) 2014 Silly Landmine Studios. All rights reserved.
//

#import "NodeGenerator.h"

@implementation NodeGenerator

- (id) init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    nodePattern = [NodePattern node];
    
    
	return self;
}

-(CGPoint)generateFirstPattern: (GameplayScene*) gameplayScene{
    return [nodePattern ChoosePattern:0 :gameplayScene];
}

//Generate a node pattern to appear on the screen.
-(CGPoint)generatePattern: (GameplayScene*) gameplayScene{
    //2. If wave is not a boss level, then spawn a regular node pattern.
        //Random number generator --> currently 1-3
        waveNum ++;
    return [nodePattern ChooseRandomPattern:waveNum :gameplayScene];
}

@end
