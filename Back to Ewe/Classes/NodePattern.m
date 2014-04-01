//
//  NodePattern.m
//  Back to Ewe
//
//  Created by Brian Chen on 3/31/14.
//  Copyright (c) 2014 Silly Landmine Studios. All rights reserved.
//

#import "NodePattern.h"

@implementation NodePattern

- (void) ChoosePattern : (int) waveNum : (GameplayScene*) gameplayScene{
    if (waveNum > 20){
        waveNum = arc4random() % 10; // Chooses from 0-10 patterns.
    }else{
        //First 10 waves just choose from the first 3 patterns
        waveNum = arc4random() % 3; //Chooses from 0-3;
    }
    
    switch (waveNum) {
        case 0:
            //Pattern 0
            
            break;
            
        case 1:
            //Pattern 1
            
            break;
            
        default:
            break;
    }
}

- (void) RandomPattern : (GameplayScene*) gameplayScene{
    
    
    
}

@end
