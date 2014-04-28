//
//  Boss.h
//  Back to Ewe
//
//  Created by administrator on 4/13/14.
//  Copyright 2014 Silly Landmine Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum BossType {
    spaceBoss,
    jungleBoss,
    BossTypeMax,
    BOSSNONE
};

@interface Boss : CCNode {
    
    float m_Radius;
    
    int m_Health;
    int m_DamageFromSheep;
    int m_DamageFromProjectile;
    
    enum BossType m_BossType;
    
    BOOL m_CanTakeDamage;
}

@property enum BossType BOSSTYPE;
@property float Radius;
@property int Health;
@property (readonly) int DamageFromSheep;
@property (readonly) int DamageFromProjectile;

-(void) setBossType;

-(void) hitBossWithSheep;

-(void) hitBossWithProjectile;

- (CGRect) rect;

- (BOOL) isPointInBoss:(CGPoint)point;

@end