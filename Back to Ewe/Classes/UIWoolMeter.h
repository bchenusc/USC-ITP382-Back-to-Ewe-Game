//
//  UIWoolMeter.h
//  Back to Ewe
//
//  Created by Jeffrey on 4/27/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UIWoolMeter : CCNode {
    CCClippingNode* m_WoolFrame;
    CCSprite* m_Stick;
    CCSprite* m_Wool;
    CCNode* m_WoolFrameStencil;
    
    float m_WoolModifier;
}

@property float Wool;

/**
 Sets the proportion of the wool that is shown.
 
 @param newWool Number from 0.0f to 1.0f that shows proportion of the wool that will be shown.
 */
- (void) setCurrentWool:(float) newWool;

@end
