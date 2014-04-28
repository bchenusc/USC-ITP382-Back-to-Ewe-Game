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

        m_HealthBar = [CCSprite spriteWithImageNamed:@"ewe_health-bar.png"];
        m_HealthBar.positionType = CCPositionTypePoints;
        m_HealthBar.position = ccp(55,-4);//TODO magic numbers
        [self addChild:m_HealthBar];
        
        CCSprite* m_HealthIcon = [CCSprite spriteWithImageNamed:@"ewe_health-icon.png"];
        [self addChild:m_HealthIcon];
        
    }
    return self;
}

@end
