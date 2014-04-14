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
#import "Powerup.h"
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
    grass = [[NSMutableArray alloc] init];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Create physics stuff
    physics = [CCPhysicsNode node];
    physics.collisionDelegate = self;
    physics.debugDraw = YES;
    physics.gravity = ccp(0, -350);
    [self addChild:physics];
    
    ScreenPhysicsBorders* borders = [ScreenPhysicsBorders node];
    [physics addChild:borders];
    
    m_Sheep = [Sheep node];
    [physics addChild:m_Sheep];
    
    nodeGenerator = [NodeGenerator node];
    
    enemyGenerator = [EnemyGenerator node];
    topEnemy = nil;
    
    grassGenerator = [GrassGenerator node];
    topGrass = nil;
    
    powerupGenerator = [PowerupGenerator node];
    topPowerup = nil;
    powerupSpacing = 1000.0f;
    powerupSpacingTolerance = 200.0f;
    
    bossLevel = NO;
    
    m_PlayerLives = 3;
    m_Dead = NO;
    
    //UI Layer
    m_UILayer = [UILayer node];
    m_UILayer.Lives = m_PlayerLives;
    [m_UILayer setGameplayScene:self];
    [self addChild:m_UILayer];
    
    m_Paused = NO;
    
    [self newGame];
    
	return self;
     
}

-(void)update:(CCTime)delta{
    
    if (m_Paused) return;
    
    for (Node* node  in nodesToDelete){
        @try{
        [physics removeChild:node];
        }
        @catch (NSException* e) {
                
        }
    }
    [nodes removeObjectsInArray:nodesToDelete];
    [nodesToDelete removeAllObjects];
    
    /*if (bossLevel){
        //Translates automatically.
        float translation = delta * 100;
        for(Node* node in nodes){
            node.position = ccp(node.position.x, node.position.y - translation);
            if (node.position.y < 0){
                [nodesToDelete addObject:node];
            }
        }
        //Scrolling
        for(Enemy* enemy in enemies) {
            [enemy setPositionAndCenter:ccp(enemy.position.x, enemy.position.y - translation)];
        }
        for (Grass* _grass in grass) {
            _grass.position =ccp(_grass.position.x, _grass.position.y - translation);
        }
        if(topPowerup != nil) {
            topPowerup.position = ccp(topPowerup.position.x, topPowerup.position.y - translation);
        }
        
        m_Sheep.position = ccp (m_Sheep.position.x, m_Sheep.position.y - translation);
        topNode = ccp(topNode.x, topNode.y - translation);

        m_UILayer.Score = score;
        
    }*/
   // else
    if (m_Sheep.position.y > 170 && m_Sheep.physicsBody.velocity.y > 0){
        float translation = delta * m_Sheep.physicsBody.velocity.y;
        
        for(Node* node in nodes){
            node.position = ccp(node.position.x, node.position.y - translation);
            if (node.position.y < 0){
                [nodesToDelete addObject:node];
            }
        }
        
        //TODO: Need to cleanup enemies and grass
        
        //Scrolling
        for(Enemy* enemy in enemies) {
            [enemy setPositionAndCenter:ccp(enemy.position.x, enemy.position.y - translation)];
        }
        for (Grass* _grass in grass) {
            _grass.position =ccp(_grass.position.x, _grass.position.y - translation);
        }
        if(topPowerup != nil) {
            topPowerup.position = ccp(topPowerup.position.x, topPowerup.position.y - translation);
        }
        
        m_Sheep.position = ccp (m_Sheep.position.x, m_Sheep.position.y - translation);
        newNodePoint = ccp(newNodePoint.x, newNodePoint.y - translation);
        topNode = ccp(topNode.x, topNode.y - translation);
        //NSLog(@"Scroll position : %f", newNodePoint.y);
    
        score += translation;
        m_UILayer.Score = score;
    }
    
    if (m_Sheep.position.y >= topNode.y) {
        //NSLog(@"topNode is : %f", topNode.y);
        topNode = [nodeGenerator generatePattern:self];
    }
    
    
    if(topPowerup != nil) {
        if(topPowerup.position.y < -topPowerup.radius) {
            [self removePowerup];
        }
    }
    
    if (m_Sheep.position.y < 0) {
        [self playerDeath];
        if (m_PlayerLives == 0) {
            [self playerDeath];
        }
        return;
    }
    
    if(topEnemy == nil) {
        [self spawnNewEnemy];
    } else if(topEnemy.position.y < 0) {
        [self removeEnemy];
        [self spawnNewEnemy];
    }
    if (topGrass == nil) {
        [self spawnNewGrass];
    } else if (topGrass.position.y < 0) {
        [self removeGrass];
        [self spawnNewGrass];
    }
    if(score >= powerupSpacing) {
        [self spawnNewPowerup];
    }
    
}
-(void) setNewNodePoint : (CGPoint) point {
    newNodePoint = point;
}
-(CGPoint) getNewNodePoint{
    return newNodePoint;
}

-(void) spawnNewPattern{
    topNode = [nodeGenerator generatePattern:self];
}

-(void)spawnNewPowerup {
    [self removePowerup];
    topPowerup = [powerupGenerator spawnPowerup];
    powerupSpacing += powerupSpacing + arc4random() % (int)powerupSpacingTolerance;
    [physics addChild:topPowerup];
}

-(void)removePowerup {
    if(topPowerup != nil) {
        [physics removeChild:topPowerup];
        topPowerup = nil;
    }
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

- (void) spawnNewGrass {
    topGrass = [grassGenerator spawnNewGrass];
    [grass addObject:topGrass];
    [physics addChild:topGrass];
    
}

- (void) removeGrass{
    [grass removeObject:topGrass];
    [physics removeChild:topGrass];
    topGrass = nil;
}

-(CGSize) getSize{
    return self.contentSize;
}

-(void) addNode : (Node*) n Position:(CGPoint)point{
    /*if (nodes.count > 10){
        [nodesToDelete addObject:[nodes objectAtIndex:(nodes.count - 1)]];
    }*/
    n.position = point;
    [n setGameplayScene:self];
    [nodes addObject:n];
    [physics addChild:n];
}

- (void) removeNode:(Node*)toRemove {
    NSAssert(toRemove != nil, @"Argument must be non-nil");
    
    if (m_Sheep.attachedNode == toRemove) {
        [m_Sheep breakString];
    }
    [nodesToDelete addObject:toRemove];
}

- (void) playerDeath {
    if (!m_Dead) {
        NSLog(@"Player died");
        m_PlayerLives--;
        m_UILayer.Lives = m_PlayerLives;
        m_Dead = YES;
        m_Sheep.visible = NO;
        m_Sheep.physicsBody.velocity = ccp(0,0);
        if (m_Sheep.attachedNode) {
            [m_Sheep breakString];
        }
        
        [self scheduleOnce:@selector(respawnPlayer) delay:2.5f];
        if (m_PlayerLives == 0) {
            [self gameOver];
        }
    }
}

- (void) respawnPlayer {
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    m_Sheep.position = ccp(winSize.width/2, winSize.height/3);
    m_Sheep.physicsBody.velocity = ccp(0, 500);
    m_Sheep.visible = YES;
    m_Sheep.CurrentHealth = m_Sheep.MaxHealth;
    m_Sheep.CurrentWool = m_Sheep.MaxWool;
    m_UILayer.Health = m_Sheep.CurrentHealth;
    m_Dead = NO;
}

- (void) gameOver {
    NSLog(@"Game Over");
    [m_UILayer gameOver];
    
}

- (void) resetGame {
    [self pause];
    
    m_Sheep.visible = NO;
    [m_Sheep breakString];
    
    /*for(Node* n in nodes) {
        [physics removeChild:n];
    }
    [nodes removeAllObjects];*/
    
    
    [nodesToDelete addObjectsFromArray:nodes];
    
    for(Grass* g in grass) {
        [physics removeChild:g];
    }
    [grass removeAllObjects];
    
    for(Enemy* e in enemies) {
        [physics removeChild:e];
    }
    [enemies removeAllObjects];
    
    newNodePoint = ccp(0, 0);
    
    topNode = ccp(0, 0);
    
    topEnemy = nil;
    
    topGrass = nil;
    
    topPowerup = nil;
    
    powerupToDelete = nil;
    
    score = 0;
    
    m_PlayerLives = 3;
    
    m_Dead = NO;
    
    [m_UILayer reset];
    
    [self newGame];
}

- (void) newGame {
    topNode = [nodeGenerator generateFirstPattern:self];
    [self spawnNewEnemy];
    [self spawnNewGrass];
    [self respawnPlayer];
    [self resume];
}

- (void) pause {
    self.paused = YES;
    m_Paused = YES;
}

- (void) resume {
    self.paused = NO;
    m_Paused = NO;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair sheep:(Sheep *)_sheep grass:(Grass *)_grass {
    _sheep.CurrentWool += _grass.RCVAmount;
    if (_sheep.CurrentWool >= _sheep.MaxWool) {
        _sheep.CurrentWool = m_Sheep.MaxWool;
    }
    [self removeGrass];
    [self spawnNewGrass];
    
    m_UILayer.Wool = _sheep.CurrentWool;
    
    return YES;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair sheep:(Sheep *)_sheep enemy:(Enemy *)enemy
{
    if([_sheep.CurrentPowerups indexOfObject:[NSNumber numberWithInt:shield]] == NSNotFound) {
        _sheep.CurrentHealth -= 10.0f;
        m_UILayer.Health = _sheep.CurrentHealth;
    }
    [self removeEnemy];
    [self spawnNewEnemy];
    
    if (_sheep.CurrentHealth <= 0) {
        [self playerDeath];
    }
    
    return YES;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair sheep:(Sheep *)_sheep powerup:(Powerup *)powerup
{
    [_sheep setPowerup:powerup.POWERUPTYPE];
    [self removePowerup];
    
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
    if (m_Paused) {
        return;
    }
    
    if (m_Dead) {
        return;
    }
    CGPoint touchLoc = [touch locationInNode:self];
    
    // Check if user clicked on a node
    bool nodeTouched = NO;
    for (Node* n in nodes) {
        if ([n isPointInNode:touchLoc]) {
            nodeTouched = YES;
            
            if (n != m_Sheep.attachedNode) {
                [m_Sheep stringToNode:n];
                [n shrinkAndRemove];
                m_UILayer.Wool = m_Sheep.CurrentWool;
            }
        }
    }
    
    // If node wasn't touched, break the current Wool
    if (!nodeTouched) {
        [m_Sheep breakString];
    }
}

@end
