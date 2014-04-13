//
//  GrassGenerator.m
//  Back to Ewe
//
//  Created by Jeffrey on 4/12/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "GrassGenerator.h"


@implementation GrassGenerator

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (Grass*) spawnNewGrass {
    CGSize size = [[CCDirector sharedDirector] viewSize];
    Grass* newGrass = [Grass node];
    
    newGrass.position = ccp(((float)(arc4random() % 100)) / 100 * (size.width - newGrass.Radius * 2) + newGrass.Radius,
                            size.height + newGrass.Radius * 2);
    
    return newGrass;
}

@end
