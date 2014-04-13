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
            //waveNum = arc4random() % 3 +1; //Chooses from 0-3;
            waveNum = 1;
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
            return [self Diagonal];
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
    topNodePosition = [gameplayScene getNewNodePoint];
    
    scrollPosition = ccp(winSize.width / 2, winSize.height / 2);
    //Bottom Left
    Node* testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                            arc4random_uniform((int)(winSize.width/2 - 100)) + 50 ,
                            arc4random_uniform((int)(winSize.height/2 - 100)) + 50)];
    
    //Bottom Right
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                            arc4random_uniform((int)(winSize.width/2 - 100)) + (int)((winSize.width/2)+ 50),
                            arc4random_uniform((int)(winSize.height/2 - 100)) + 50)];
    
    //Top left
    int topLeftY =
                            arc4random_uniform((int)(winSize.height/2 - 100)) + (int)((winSize.height/2)+ 50);
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                            arc4random_uniform((int)(winSize.width/2 - 100)) + 50,
                            topLeftY)];
    
    //Top right
    int topRightY =
                            arc4random_uniform((int)(winSize.height/2 - 100)) + (int)((winSize.height/2)+ 50);
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                             arc4random_uniform((int)(winSize.width/2 - 100)) + (int)((winSize.width/2)+ 50),
                            topLeftY)];
    //Top node
    if (topLeftY > topRightY){
        topNodePosition =ccp(0, topLeftY + 50);
        
    }else{
        topNodePosition =ccp(0, topRightY + 50);
    }
    [gameplayScene setNewNodePoint:topNodePosition];
    return scrollPosition;
}

- (CGPoint) FourNodesHigh{
    topNodePosition = [gameplayScene getNewNodePoint];
    
    scrollPosition = ccp(winSize.width / 2, winSize.height / 2);
    //Bottom Left
    Node* testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + 50 ,
                                                  topNodePosition.y + arc4random_uniform((int)(winSize.height/2 - 100)) + 50)];
    
    //Bottom Right
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + (int)((winSize.width/2)+ 50),
                                                  topNodePosition.y + arc4random_uniform((int)(winSize.height/2 - 100)) + 50)];
    
    //Top left
    int topLeftY =
    topNodePosition.y + arc4random_uniform((int)(winSize.height/2 - 100)) + (int)((winSize.height/2)+ 50);
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + 50,
                                                  topLeftY)];
    
    //Top right
    int topRightY =
    topNodePosition.y + arc4random_uniform((int)(winSize.height/2 - 100)) + (int)((winSize.height/2)+ 50);
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + (int)((winSize.width/2)+ 50),
                                                  topLeftY)];
    //Top node
    if (topLeftY > topRightY){
        topNodePosition =ccp(0, topLeftY + 50);
        
    }else{
        topNodePosition =ccp(0, topRightY + 50);
    }
    [gameplayScene setNewNodePoint:topNodePosition];
    return scrollPosition;
}

- (CGPoint) Diagonal{
    topNodePosition = [gameplayScene getNewNodePoint];
    
    scrollPosition = ccp(0, topNodePosition.y + winSize.height / 2);
    
    //Bottom Left
    Node* testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(arc4random() % ((int)(winSize.width/4 - 10)) + 10 ,
                                                  topNodePosition.y + arc4random() % ((int)(winSize.height/4 - 10)) + 10)];
    
    //Bottom Left #2
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(arc4random() % ((int)(winSize.width/2 - 10)) + (int)(winSize.width/4) + 10 ,
                                                  topNodePosition.y + arc4random() % ((int)(winSize.height/2 - 10)) +
                                                                                       (int)(winSize.height/4) + 10)];
    
    //Top Right
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(arc4random() % ((int)(winSize.width*3/4 - 10)) + (int)(winSize.width/2) + 10 ,
                                                  topNodePosition.y + arc4random() % ((int)(winSize.height*3/4 - 10)) +
                                                  (int)(winSize.height/2) + 10)];
    //Top Right #2
    topNodePosition = ccp(arc4random() % ((int)(winSize.width - 10)) + (int)(winSize.width*3/4) + 10 ,
                          topNodePosition.y + arc4random() % ((int)(winSize.height - 10)) +
                          (int)(winSize.height*3/4) + 10);
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: topNodePosition];
    //Top node
    [gameplayScene setNewNodePoint:topNodePosition];
    
    return scrollPosition;
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
