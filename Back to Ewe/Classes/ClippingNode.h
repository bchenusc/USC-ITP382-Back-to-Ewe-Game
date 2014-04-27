//
//  ClippingNode.h
//  Back to Ewe
//
//  Created by Jeffrey on 4/27/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//  Copied from http://www.learn-cocos2d.com/2011/01/cocos2d-gem-clippingnode/

[cc lang="objc"]
#import
#import “cocos2d.h”

/** Restricts (clips) drawing of all children to a specific region. */
@interface ClippingNode : CCNode
{
    CGRect clippingRegionInNodeCoordinates;
    CGRect clippingRegion;
}

@property (nonatomic) CGRect clippingRegion;

@end
[/cc]
