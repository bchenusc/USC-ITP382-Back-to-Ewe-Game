//
//  Explosion.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 4/27/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "AnimatingSprite.h"
#import "CCAnimation.h"

@implementation AnimatingSprite

@synthesize repeating = m_Repeat;
@synthesize destroyOnAnimationFinish = m_DestroyOnAnimationFinish;
@synthesize frameDelay = m_frameDelay;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFiles:(NSMutableArray *)files repeat:(bool)repeat destroyOnFinish:(bool)destroyOnFinish delay:(CGFloat)delay {
    m_Repeat = repeat;
    m_DestroyOnAnimationFinish = destroyOnFinish;
    m_frameDelay = delay;
    
    [self setupAnimationWithFiles:files];
    
    return self;
}

- (void)setupAnimationWithFiles:(NSMutableArray *)files {
    for (int i = 0; i < files.count; i++) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFrame: [CCSpriteFrame frameWithImageNamed:[files objectAtIndex:i]] name:[files objectAtIndex:i]];
    }
    
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < files.count; i++) {
        NSString* file = [files objectAtIndex:i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file];
        [frames addObject:frame];
    }
    
    // Start new animation
    CCAnimation* anim = [CCAnimation animationWithSpriteFrames:frames delay:m_frameDelay];
    CCActionAnimate* animate = [CCActionAnimate actionWithAnimation:anim];
    
    if (m_Repeat) {
        CCActionRepeatForever* repeat = [CCActionRepeatForever actionWithAction:animate];
        [self runAction:repeat];
    } else {
        if (m_DestroyOnAnimationFinish) {
            [self runAction:[CCActionSequence actionOne:animate two:[CCActionRemove new]]];
        } else {
            [self runAction:animate];
        }
    }
}

@end
