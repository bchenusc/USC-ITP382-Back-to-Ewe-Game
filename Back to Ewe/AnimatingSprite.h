//
//  Explosion.h
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 4/27/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AnimatingSprite : CCSprite {
    bool m_Repeat;
    bool m_DestroyOnAnimationFinish;
    CGFloat m_frameDelay;
}

// Always init with this
- (instancetype)initWithFiles:(NSMutableArray *)files repeat:(bool)repeat destroyOnFinish:(bool)destroyOnFinish delay:(CGFloat)delay;

@property (readonly) bool repeating;
@property (readonly) bool destroyOnAnimationFinish;
@property (readonly) CGFloat frameDelay;

@end
