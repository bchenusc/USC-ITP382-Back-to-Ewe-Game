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
        
        m_Stick = [CCSprite spriteWithImageNamed:@"ewe_wool-stick.png"];
        [self addChild:m_Stick];
        
        m_WoolModifier = 1.0f;
        m_WoolFrameStencil = [CCSprite spriteWithImageNamed:@"ewe_wool-blank.png"];
        //[m_WoolFrameStencil setContentSize:CGSizeMake([m_Wool contentSize].width, [m_Wool contentSize].height*m_WoolModifier)];
        m_WoolFrameStencil.scaleY = 1.0f;
        m_WoolFrameStencil.position = ccp(0, 20/112);
        
        m_WoolFrame = [[CCClippingNode alloc] initWithStencil:m_WoolFrameStencil];
        m_Wool = [CCSprite spriteWithImageNamed:@"ewe_wool-thread-2.png"];
        m_WoolFrame.inverted = NO;
        [m_WoolFrame addChild:m_Wool];
        
        [self addChild:m_WoolFrame];
    }
    return self;
}

- (void) setCurrentWool:(float)newWool {
    m_WoolFrameStencil.scaleY = newWool;
    NSLog(@"blah");
}


@end
