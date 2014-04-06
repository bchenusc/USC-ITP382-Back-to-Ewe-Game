//
//  NodePattern.m
//  Back to Ewe
//
//  Created by Brian Chen on 3/31/14.
//  Copyright (c) 2014 Silly Landmine Studios. All rights reserved.
//

#import "NodePattern.h"

@implementation NodePattern

- (void) ChoosePattern: (int) waveNum : (GameplayScene*) gameScene{
    winSize = [gameScene getSize];
    gameplayScene = gameScene;
    if (waveNum > 20){
        waveNum = arc4random() % 1 * 0; // Chooses from 0-10 patterns.
    }else{
        //First 10 waves just choose from the first 3 patterns
        waveNum = arc4random() % 1 * 0; //Chooses from 0-3;
    }
    
    switch (waveNum) {
        case 0:
            //Pattern 0 = Test 4 nodes.
            [self FourNodes];
            break;
        case 1:
            //Pattern 1
            
            break;
            
        default:
            break;
    }
}

//Spawns 4 nodes at set locations.
- (void) FourNodes{
    Node* testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 5, winSize.height - winSize.height / 8)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 5 * 4, winSize.height - winSize.height / 8)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 2, winSize.height / 2)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 5, winSize.height / 4)];
}

@end
