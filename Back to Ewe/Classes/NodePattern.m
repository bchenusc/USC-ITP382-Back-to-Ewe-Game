//
//  NodePattern.m
//  Back to Ewe
//
//  Created by Brian Chen on 3/31/14.
//  Copyright (c) 2014 Silly Landmine Studios. All rights reserved.
//

#import "NodePattern.h"

@implementation NodePattern


- (CGPoint) ChooseRandomPattern: (int) waveNum : (GameplayScene*) gameScene{
    winSize = [gameScene getSize];
    gameplayScene = gameScene;
    if (waveNum > 20){
        waveNum = arc4random() % 1 +1; // Chooses from 0-10 patterns.
    }else{
        //First 10 waves just choose from the first 3 patterns
        waveNum = arc4random() % 1 +1; //Chooses from 0-3;
    }
    
    return [self PatternSwitchStatement:waveNum];
}
- (CGPoint) ChoosePattern: (int) patterNum : (GameplayScene*) gameScene{
    winSize = [gameScene getSize];
    gameplayScene = gameScene;
    return [self PatternSwitchStatement:patterNum];
}

- (CGPoint) PatternSwitchStatement: (int) patternNum{
    switch (patternNum) {
        case 0:
            //Pattern 0 = Test 4 nodes.
            return [self FourNodesInit];
        case 1:
            //Pattern 1
            return [self FourNodesHigh];
            break;
            
        default:
            break;
    }
    return ccp(0,0);
}


//Spawns 4 nodes at set locations.
- (CGPoint) FourNodesInit{
    Node* testNode = [Node node];
    topNodePosition = ccp(winSize.width / 2, winSize.height / 2);
    [gameplayScene addNode:testNode Position: ccp(winSize.width / 5, winSize.height - winSize.height / 8)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 5 * 4, winSize.height - winSize.height / 8) ];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:topNodePosition];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 5, winSize.height / 4)];
    return topNodePosition;
}
- (CGPoint) FourNodesHigh{
    Node* testNode = [Node node];
    topNodePosition = ccp(winSize.width / 2, winSize.height / 2+ 400);
    [gameplayScene addNode:testNode Position: ccp(winSize.width / 5, winSize.height - winSize.height / 8 + 400)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 5 * 4, winSize.height - winSize.height / 8+ 400) ];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:topNodePosition];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 5, winSize.height / 4 + 400)];
    return topNodePosition;
}

@end
