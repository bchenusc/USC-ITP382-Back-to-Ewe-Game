//
//  UIHealthMeter.h
//  Back to Ewe
//
//  Created by Jeffrey on 4/27/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UIHealthMeter : CCNode {
    int m_CurrentLives;
    
    CCSprite* m_HealthBar;
}

@property int Lives;


@end
