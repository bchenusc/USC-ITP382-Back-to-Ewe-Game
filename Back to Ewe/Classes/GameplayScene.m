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
#import "Grass.h"
#import "Enemy.h"
#import "ScreenPhysicsBorders.h"

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
    nodesToDelete = [[NSMutableArray alloc]init];
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
    //physics.debugDraw = YES;
    physics.gravity = ccp(0, -350);
    [self addChild:physics];
    
    ScreenPhysicsBorders* borders = [ScreenPhysicsBorders node];
    [physics addChild:borders];
    
    sheep = [Sheep node];
    [physics addChild:sheep];
    
    scrollCenter = ccp(self.contentSize.width / 2, self.contentSize.height/2);
    scrollSpeed = 100.0f;
    
    nodeGenerator = [NodeGenerator node];
    topNode = [nodeGenerator generateFirstPattern:self];
    
    enemyGenerator = [EnemyGenerator node];
    topEnemy = nil;
    [self spawnNewEnemy];
    
    Grass* testGrass = [Grass node];
    testGrass.position = ccp(2*self.contentSize.width / 3, 3*self.contentSize.height /8);
    [physics addChild:testGrass];
    
    //UI Layer
    m_UILayer = [UILayer node];
    [self addChild:m_UILayer];
    
    
	return self;
     
}

-(void)update:(CCTime)delta{
    if (sheep.position.y >= topNode.y){
        topNode = [nodeGenerator generatePattern:self];
    }
    
    for (Node* node  in nodesToDelete){
        [physics removeChild:node];
    }
    [nodes removeObjectsInArray:nodesToDelete];
    [nodesToDelete removeAllObjects];
    
    if (sheep.position.y > scrollCenter.y && sheep.physicsBody.velocity.y > 0){
        float translation = delta * sheep.physicsBody.velocity.y;
        for(Node* node in nodes){
            node.position = ccp(node.position.x, node.position.y - translation);
            if (node.position.y < 0){
                [nodesToDelete addObject:node];
            }
        }
        for(Enemy* enemy in enemies) {
            [enemy setPositionAndCenter:ccp(enemy.position.x, enemy.position.y - translation)];
        }
        sheep.position = ccp (sheep.position.x, sheep.position.y - translation);
        topNode = ccp(topNode.x, topNode.y - translation);
    
        
    }
    
    if (sheep.position.y < 0) {
        NSLog(@"Game Over");
        //RUN GAMEOVER CODE
    }
    
    if(topEnemy == nil) {
        [self spawnNewEnemy];
    } else if(topEnemy.position.y < 0) {
        [self removeEnemy];
        [self spawnNewEnemy];
    }
}

-(void) spawnNewPattern{
    topNode = [nodeGenerator generatePattern:self];
}

-(void)spawnNewEnemy {
    topEnemy = [enemyGenerator spawnEnemy];
    [enemies addObject: topEnemy];
    [physics addChild:topEnemy];
}

-(void)removeEnemy {
    [enemies removeObject:topEnemy];
    [physics removeChild:topEnemy];
    topEnemy = nil;
}

-(CGSize) getSize{
    return self.contentSize;
}

-(void) addNode : (Node*) n Position:(CGPoint)point{
    n.position = point;
    [n setGameplayScene:self];
    [nodes addObject:n];
    [physics addChild:n];
}

- (void) removeNode:(Node*)toRemove {
    NSAssert(toRemove != nil, @"Argument must be non-nil");
    
    if (sheep.attachedNode == toRemove) {
        [sheep breakString];
    }
    [nodesToDelete addObject:toRemove];
}

- (void) playerDeath {
    
}

- (void) gameOver {
    
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair sheep:(Sheep *)sheep node:(Node *)node
{
    static int collisionCountSheepNode = 0;
    collisionCountSheepNode++;
	//NSLog(@"Collision %d between sheep and node.", collisionCountSheepNode);

    return YES;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair sheep:(Sheep *)_sheep grass:(Grass *)grass {
    _sheep.CurrentWool += grass.RCVAmount;
    if (_sheep.CurrentWool >= _sheep.MaxWool) {
        _sheep.CurrentWool = sheep.MaxWool;
    }
    m_UILayer.Wool = _sheep.CurrentWool;
    
    return YES;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair sheep:(Sheep *)sheep enemy:(Enemy *)enemy
{
	NSLog(@"Collision:%@ between sheep and enemy.", enemy);
    
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
    
    // Check if user clicked on a node
    bool nodeTouched = NO;
    for (Node* n in nodes) {
        if ([n isPointInNode:touchLoc]) {
            nodeTouched = YES;
            
            if (n != sheep.attachedNode) {
                [sheep stringToNode:n];
                [n shrinkAndRemove];
                m_UILayer.Wool = sheep.CurrentWool;
            }
        }
    }
    
    // If node wasn't touched, break the current Wool
    if (!nodeTouched) {
        [sheep breakString];
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
