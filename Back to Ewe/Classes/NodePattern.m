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
        if (waveNum == 0);
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
        case 2:
            //Square
            return [self Square];
            break;
        case 3:
            //Pentagon
            break;
        case 4:
            //Hexagon
            break;
        case 5:
            //Triangle
            break;
        case 6:
            //Random 5 Nodes
            break;
        case 7:
            //Random 4 Nodes
            break;
        case 8:
            //Random 3 Nodes
            break;
        case 9:
            //Random 2 Nodes
            break;
        case 10:
            //Random 1 Node
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
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 5 * 4, winSize.height - winSize.height / 8 - 80) ];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:topNodePosition];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 2.5f - 20, winSize.height / 4)];
    return topNodePosition;
}

- (CGPoint) FourNodesHigh{
    Node* testNode = [Node node];
    topNodePosition = ccp(winSize.width / 2, winSize.height / 2+ 400);
    [gameplayScene addNode:testNode Position: ccp(winSize.width / 3, winSize.height - winSize.height / 8 + 400)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 5 * 4, winSize.height - winSize.height / 8+ 400 - 80) ];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:topNodePosition];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 7, winSize.height / 4 + 400)];
    return topNodePosition;
}
- (CGPoint) Square{
    Node* testNode = [Node node];
    int randWidth = arc4random() % winSize.width + 1;
    int randHeight = arc4random() % winSize.height + 1;
    topNodePosition = ccp(winSize.width / 2, winSize.height / 2);
    [gameplayScene addNode:testNode Position: ccp(winSize.width / 5, winSize.height - winSize.height / 5)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width - winSize.width/ 5, winSize.height - winSize.height / 5) ];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 5, winSize.height/ 5)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width - winSize.width / 5, winSize.height /5)];
    return topNodePosition;
}

@end
