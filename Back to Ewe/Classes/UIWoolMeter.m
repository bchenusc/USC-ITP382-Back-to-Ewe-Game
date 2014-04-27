//
//  UIWoolMeter.m
//  Back to Ewe
//
//  Created by Jeffrey on 4/27/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "UIWoolMeter.h"

@implementation UIWoolMeter

@synthesize Wool = m_WoolModifier;

- (instancetype)init
{
    self = [super init];
    if (self) {
        float ScaleMultFix = 0.1f;
        
        m_Stick = [CCSprite spriteWithImageNamed:@"ewe_wool-stick.png"];
        m_Stick.scale *= ScaleMultFix;
        [self addChild:m_Stick];
        
        m_WoolFrame = [[CCClippingNode alloc] init];
        m_Wool = [CCSprite spriteWithImageNamed:@"ewe_wool-thread-2.png"];
        m_Wool.scale *= ScaleMultFix;
        [m_WoolFrame addChild:m_Wool];
        
        m_WoolModifier = [self contentSize].height;
        m_WoolFrameStencil = [[CCNode alloc] init];
        [m_WoolFrameStencil setContentSize:CGSizeMake([m_Wool contentSize].width, [m_Wool contentSize].height*m_WoolModifier)];
        
        [m_WoolFrame setStencil:m_WoolFrameStencil];
        
        [self addChild:m_WoolFrame];
    }
    return self;
}

- (void) setCurrentWool:(float)newWool {
    m_WoolModifier = newWool;
    [m_WoolFrameStencil setContentSize:CGSizeMake([m_Wool contentSize].width, [m_Wool contentSize].height*m_WoolModifier)];
}


@end
