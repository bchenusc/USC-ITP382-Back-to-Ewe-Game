//
//  NodeGenerator.h
//  Back to Ewe
//
//  Created by Brian Chen on 3/31/14.
//  Copyright (c) 2014 Silly Landmine Studios. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "NodePattern.h"

@interface NodeGenerator : NSObject
{
    int roundNum;   //every 10 waves is a round.
    int waveNum;    //every pattern is 1 wave.
    NodePattern* nodePattern;
    
}

-(void)generatePattern:(int)score : (HelloWorldScene*) gameplayScene;
-(void) update: (CCTime)dt;

@end
