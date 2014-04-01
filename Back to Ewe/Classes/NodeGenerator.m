//
//  NodeGenerator.m
//  Back to Ewe
//
//  Created by Brian Chen on 3/31/14.
//  Copyright (c) 2014 Silly Landmine Studios. All rights reserved.
//

#import "NodeGenerator.h"

@implementation NodeGenerator


//Generate a node pattern to appear on the screen.
-(void)generatePattern:(int)score : (GameplayScene*) gameplayScene{
    //1. If it is a boss level, then spawn a boss level node pattern.
    if (waveNum > 9 && waveNum % 10 == 0){
        //Boss level!
        waveNum ++;
        int bossLevel = waveNum / 10;
        //Spawn a boss level node pattern here.
        
        return;
    }else{
    //2. If wave is not a boss level, then spawn a regular node pattern.
        //Random number generator --> currently 1-3
        [nodePattern ChoosePattern:waveNum : gameplayScene];
    }
    
}

- (void)update:(CCTime)dt{
    
}


@end
