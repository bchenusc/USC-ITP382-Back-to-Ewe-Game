//
//  UIHealthMeter.m
//  Back to Ewe
//
//  Created by Jeffrey on 4/27/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import "UIHealthMeter.h"


@implementation UIHealthMeter

@synthesize Lives = m_CurrentLives;

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"Blah");
        CCSprite* m_HealthIcon = [CCSprite spriteWithImageNamed:@"ewe_health-icon.png"];
        //m_HealthIcon.position = ccp(0,0);
        [self addChild:m_HealthIcon];
        
//        m_LivesIcon = [CCSprite spriteWithImageNamed:@"itp382sheep.png"];
//        m_LivesIcon.scale = 0.6f;
//        //m_LivesIcon.position = ccp(0.5f,-1.0);
//        [self addChild:m_LivesIcon];
//        
//        m_LivesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", m_CurrentLives] fontName:@"lovenesstwo" fontSize:16.0f];
//        //m_LivesLabel.position =ccp(0, -1.0);
//        [self addChild:m_LivesLabel];
    }
    return self;
}

@end
