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
        waveNum = arc4random() % 5 +3; // Chooses from 0-10 patterns.
    }else{
        if (waveNum > 40){
            waveNum = arc4random()%7 + 5;
        }else{
            //First 20 waves just choose from the first 3 patterns
            waveNum = arc4random() % 3 +1; //Chooses from 0-3;
        }
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
            return [self RandFourNodesHigh];
            break;
        case 4:
            //Triangle
            return [self Triangle];
            break;
        case 5:
            return [self RandThreeNodesHigh];
            break;
        case 6:
            return [self RandTwoNodesHigh];
            break;
        case 7:
            return [self RandOneNodeHigh];
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
    topNodePosition = ccp(winSize.width / 2 - arc4random() % 100, winSize.height / 2+ 400);
    [gameplayScene addNode:testNode Position: ccp(winSize.width / 3 - arc4random() % 10, winSize.height - winSize.height / 8 + 400 - arc4random() % 100)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 5 * 4 - arc4random() % 100, winSize.height - winSize.height / 8+ 400 - 80 )];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:topNodePosition];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(winSize.width / 7 + arc4random() % 50, winSize.height / 4 + 400)];
    return topNodePosition;
}
- (CGPoint) RandFourNodesHigh{
    Node* testNode = [Node node];
    topNodePosition = ccp(arc4random() % (int)(winSize.width - 50) + 50, winSize.height / 2 + 400);
    [gameplayScene addNode:testNode Position: ccp(arc4random() % (int)(winSize.width - 50) + 50, arc4random() % (int)(winSize.height - 50) + 450)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(arc4random() % (int)(winSize.width - 50) + 50, arc4random() % (int)(winSize.height - 50) + 450)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: topNodePosition];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(arc4random() % (int)(winSize.width - 50) + 50, arc4random() % (int)(winSize.height - 50) + 450)];
    return topNodePosition;
}
- (CGPoint) RandThreeNodesHigh{
    Node* testNode = [Node node];
    topNodePosition = ccp(arc4random() % (int)(winSize.width - 50) + 50, winSize.height / 2 + 400);
    [gameplayScene addNode:testNode Position: ccp(arc4random() % (int)(winSize.width - 50) + 50, arc4random() % (int)(winSize.height - 50) + 450)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: topNodePosition];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(arc4random() % (int)(winSize.width - 50) + 50, arc4random() % (int)(winSize.height - 50) + 450)];
    return topNodePosition;
}
- (CGPoint) RandTwoNodesHigh{
    Node* testNode = [Node node];
    topNodePosition = ccp(arc4random() % (int)(winSize.width - 50) + 50, winSize.height / 2 + 400);
    [gameplayScene addNode:testNode Position: ccp(arc4random() % (int)(winSize.width - 50) + 50, arc4random() % (int)(winSize.height - 50) + 450)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: topNodePosition];
    testNode = [Node node];
    return topNodePosition;
}
- (CGPoint) RandOneNodeHigh{
    Node* testNode = [Node node];
    topNodePosition = ccp(arc4random() % (int)(winSize.width - 50) + 50, winSize.height / 2 + 400);
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: topNodePosition];
    return topNodePosition;
}

- (CGPoint) Square{
    Node* testNode = [Node node];
    int offsetw = arc4random() % ((int) winSize.width-30) + 20;
    int offseth = arc4random() % ((int) winSize.height-100) + 1;
    int randWidth = arc4random() % (int)(offsetw/2) + 20;
    int randHeight = arc4random() % (int)(offseth/4) + 50;
    topNodePosition = ccp(winSize.width / 2, offseth + randHeight/2 + 300);
    [gameplayScene addNode:testNode Position: ccp(offsetw + randWidth, offseth+ randHeight + 400)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(offsetw + randWidth, offseth - randHeight + 400) ];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(offsetw- randWidth, offseth+ randHeight + 400)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(offsetw - randWidth, offseth- randHeight + 400)];
    return topNodePosition;
}

- (CGPoint) Triangle{
    Node* testNode = [Node node];
    int offsetw = arc4random() % ((int) winSize.width-30) + 20;
    int offseth = arc4random() % ((int) winSize.height-100) + 1;
    int randWidth = arc4random() % (int)(offsetw/2) + 20;
    int randHeight = arc4random() % (int)(offseth/4) + 50;
    topNodePosition = ccp(winSize.width / 2, offseth + randHeight/2 + 300);
    [gameplayScene addNode:testNode Position: ccp(offsetw, offseth+ randHeight + 400)];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(offsetw + randWidth, offseth - randHeight + 400) ];
    testNode = [Node node];
    [gameplayScene addNode:testNode Position:ccp(offsetw - randWidth, offseth- randHeight + 400)];
    return topNodePosition;
}

@end
