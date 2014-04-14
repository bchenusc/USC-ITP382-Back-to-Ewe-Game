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
    if (waveNum > 100){
        waveNum = arc4random_uniform(2)+1; // Chooses from 0-10 patterns.
    }else{
        //First 20 waves just choose from the first 3 patterns
        waveNum = arc4random_uniform(3)+1;
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
                                                  topNodePosition.y + 10)];
    
    //Bottom Right
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + (int)((winSize.width/2)+ 50),
                                                  topNodePosition.y + arc4random_uniform((int)(winSize.height/2 - 100)) + 50)];
    
    
    //Support Node
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + 50,
                                                  topNodePosition.y + 240)];
    
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
    
    //Bottom Left
    Node* testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/4 - 80)) + 40,
                                                  topNodePosition.y)];

    //Bottom Left #2
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/4 - 80)) + 40 +
                                                  winSize.width/4,
                                                  topNodePosition.y + arc4random_uniform((int)(winSize.height/4 - 100)) + 50 +
                                                  winSize.height/4
                                                  )];
    
    //Top Right
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/4 - 80)) + 40 +
                                                  winSize.width/2,
                                                  topNodePosition.y + arc4random_uniform((int)(winSize.height/4 - 100)) + 50+
                                                  winSize.height/2
                                                  )];
    
    //Top Right # 2
    testNode = [Node node];
    topNodePosition = ccp(0, topNodePosition.y + arc4random_uniform((int)(winSize.height/4 - 80)) + 40+
                          winSize.height*3/4);
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/4 - 100)) + 50 +
                                                  winSize.width*3/4,
                                                  topNodePosition.y
                                                  )];
    
    //Top node
    [gameplayScene setNewNodePoint:topNodePosition];
    
    scrollPosition = ccp(0, 240);
    return scrollPosition;
}

- (CGPoint) RandThreeNodesHigh{
    topNodePosition = [gameplayScene getNewNodePoint];
    
    scrollPosition = ccp(winSize.width / 2, winSize.height / 2);
    //Bottom Left
    Node* testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + 50 ,
                                                  topNodePosition.y)];
    
    
    //Top left
    int topLeftY =
    topNodePosition.y + arc4random_uniform((int)(winSize.height/2 - 100)) + (int)((winSize.height/2)+ 50);
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + 50,
                                                  topLeftY)];
    //Support Node
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + 50,
                                                  topNodePosition.y + 240)];
    
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
- (CGPoint) RandTwoNodesHigh{
    topNodePosition = [gameplayScene getNewNodePoint];
    
    scrollPosition = ccp(winSize.width / 2, winSize.height / 2);
    CGPoint bottomLeft = ccp(arc4random_uniform(winSize.width/2) + 50, topNodePosition.y + arc4random_uniform(winSize.height/2) + 50);
    CGPoint topRight = ccp((arc4random_uniform(abs(winSize.width - bottomLeft.x) * 2/5) + bottomLeft.x + 50) / 2,
                           topNodePosition.y);
    
    //Bottom Left
    Node* testNode = [Node node];
    [gameplayScene addNode:testNode Position: bottomLeft];
    
    //Support Node
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + 50,
                                                  topNodePosition.y + 240)];
    
    //Bottom Right
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: topRight
     ];
    
    topRight = ccp(0, topRight.y + 50);
    
    [gameplayScene setNewNodePoint:topRight];
    return scrollPosition;
}
- (CGPoint) RandOneNodeHigh{
    topNodePosition = [gameplayScene getNewNodePoint];
    
    scrollPosition = ccp(winSize.width / 2, winSize.height / 2);
    
    topNodePosition =ccp(
                         arc4random_uniform((int)(winSize.width - 100)) + 50 ,
                         topNodePosition.y);
    //Bottom Left
    Node* testNode = [Node node];
    [gameplayScene addNode:testNode Position: topNodePosition];
    
    //Support Node
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + 50,
                                                  topNodePosition.y + 240)];
    
    topNodePosition = ccp(topNodePosition.x, topNodePosition.y + 50);
    
    
    [gameplayScene setNewNodePoint:topNodePosition];
    return scrollPosition;

}

- (CGPoint) Square{
    topNodePosition = [gameplayScene getNewNodePoint];
    
    scrollPosition = ccp(winSize.width / 2, winSize.height / 2);
    CGPoint bottomLeft = ccp(arc4random_uniform(winSize.width/2) + 50, topNodePosition.y);
    CGPoint topRight = ccp(arc4random_uniform(abs(winSize.width - bottomLeft.x) * 2/5) + bottomLeft.x + 50,
                           topNodePosition.y + arc4random_uniform(abs(winSize.height/2) + 50));
    
    //Bottom Left
    Node* testNode = [Node node];
    [gameplayScene addNode:testNode Position: bottomLeft];
    
    //Bottom Right
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  topRight.x,
                                                  bottomLeft.y)
                                                  ];
    
    //Support Node
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + 50,
                                                  topNodePosition.y + 240)];
    
    //Top Left
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  bottomLeft.x,
                                                  topRight.y)
     ];
    
    //Top Right
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: topRight];
    
    topRight = ccp(0, topRight.y + 50);
    
    [gameplayScene setNewNodePoint:topRight];
    return scrollPosition;
}

- (CGPoint) Triangle{
    topNodePosition = [gameplayScene getNewNodePoint];
    
    scrollPosition = ccp(winSize.width / 2, winSize.height / 2);
    CGPoint bottomLeft = ccp(arc4random_uniform(winSize.width/2) + 50, topNodePosition.y + arc4random_uniform(winSize.height/2) + 50);
    CGPoint topRight = ccp((arc4random_uniform(abs(winSize.width - bottomLeft.x) * 2/5) + bottomLeft.x + 50) / 2,
                           topNodePosition.y + arc4random_uniform(abs(winSize.height/2) + 50));
    
    //Bottom Left
    Node* testNode = [Node node];
    [gameplayScene addNode:testNode Position: bottomLeft];
    
    //Support Node
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  arc4random_uniform((int)(winSize.width/2 - 100)) + 50,
                                                  topNodePosition.y + 240)];
    
    //Bottom Right
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: ccp(
                                                  topRight.x * 2,
                                                  bottomLeft.y)
     ];
    
    //Top Right
    testNode = [Node node];
    [gameplayScene addNode:testNode Position: topRight];
    
    topRight = ccp(0, topRight.y + 50);
    
    [gameplayScene setNewNodePoint:topRight];
    return scrollPosition;
}

@end
