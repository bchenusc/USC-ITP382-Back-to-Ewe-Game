//
//  WoolString.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "WoolString.h"


@implementation WoolString

- (instancetype)init {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        self.position = ccp(winSize.width / 2, winSize.height - winSize.height / 15);
        [self drawDot:ccp(0, 0) radius:30 color:[CCColor redColor]];
    }
    return self;
}

@end
