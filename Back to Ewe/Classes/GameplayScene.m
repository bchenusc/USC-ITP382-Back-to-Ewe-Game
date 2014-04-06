//
//  GameplayScene.m
//  Back to Ewe
//
//  Created by Matthew Pohlmann on 3/31/14.
//  Copyright Silly Landmine Studios 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "GameplayScene.h"
#import "MainMenuScene.h"
#import "Node.h"
#import "WoolString.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation GameplayScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (GameplayScene *) scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id) init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    nodes = [[NSMutableArray alloc] init];
    enemies = [[NSMutableArray alloc] init];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    // Create physics stuff
    physics = [CCPhysicsNode node];
    physics.collisionDelegate = self;
    physics.debugDraw = YES;
    physics.gravity = ccp(0, -200);
    [self addChild:physics];
    
    sheep = [Sheep node];
    [physics addChild:sheep];
    
    nodeGenerator = [NodeGenerator node];
    [nodeGenerator generatePattern:self];
    
    /*Node* testNode = [Node node];
    testNode.position = ccp(self.contentSize.width / 5, self.contentSize.height - self.contentSize.height / 8);
    [nodes addObject:testNode];
    [physics addChild:testNode];
    
    testNode = [Node node];
    testNode.position = ccp(self.contentSize.width / 5 * 4, self.contentSize.height - self.contentSize.height / 8);
    [nodes addObject:testNode];
    [physics addChild:testNode];
    
    testNode = [Node node];
    testNode.position = ccp(self.contentSize.width / 2, self.contentSize.height / 2);
    [nodes addObject:testNode];
    [physics addChild:testNode];
    
    testNode = [Node node];
    testNode.position = ccp(self.contentSize.width / 5, self.contentSize.height / 4);
    [nodes addObject:testNode];
    [physics addChild:testNode];
    */
    
    //UI Layer
    m_UILayer = [UILayer node];
    [self addChild:m_UILayer];
    
    
	return self;
     
}

-(CGSize) getSize{
    return self.contentSize;
}

-(void) addNode : (Node*) n Position:(CGPoint)point{
    n.position = point;
    [nodes addObject:n];
    [physics addChild:n];
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair sheep:(Sheep *)sheep node:(Node *)node
{
    static int collisionCountSheepNode = 0;
    collisionCountSheepNode++;
	//NSLog(@"Collision %d between sheep and node.", collisionCountSheepNode);

    return YES;
}

// -----------------------------------------------------------------------

- (void) dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void) onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void) onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
    // Log touch location
    //CCLOG(@"Location touched: %@",NSStringFromCGPoint(touchLoc));
    
    // Check if user clicked on a node
    for (Node* n in nodes) {
        if ([n isPointInNode:touchLoc]) {
            [sheep stringToNode:n];
            NSLog(@"StringLength: %f", [WoolString findStringLengthFromSheep:sheep toNode:n]);
            m_UILayer.Wool = sheep.CurrentWool;
        }
    }
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void) onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
