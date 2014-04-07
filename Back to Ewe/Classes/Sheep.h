//
//  Sheep.h
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Node.h"
#import "WoolString.h"
@class GameplayScene;

@interface Sheep : CCDrawNode {
    WoolString* m_WoolString;
    Node* m_AttachedNode;

    float m_currentWool;
}

@property float CurrentWool;

- (void) stringToNode:(Node*)node;

@end
