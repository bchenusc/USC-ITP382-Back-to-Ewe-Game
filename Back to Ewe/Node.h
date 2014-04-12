//
//  Node.h
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Node : CCDrawNode {
    CGFloat m_Radius;
    bool deleteMe;
    
  
}

@property (readonly) CGFloat radius;

- (CGRect) rect;

- (BOOL) isPointInNode:(CGPoint)point;

@end
