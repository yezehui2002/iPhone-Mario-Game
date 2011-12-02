//
//  GamePlay.m
//  FirstGame2
//
//  Created by Andres on 5/17/11.
//  Copyright 2011 Kennesaw State University. All rights reserved.
//

#import "GamePlay.h"
#import "PauseScene.h"
#import "GameOver.h"
#import "HelloWorldLayer.h"

@implementation GamePlay

enum {
    kTagHero,
    kTagEnemy,
    kTagFireball
};

+(id) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	GamePlay *layer = [GamePlay node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}


-(void) ccTouchesMoved:(NSSet *)touches
             withEvent:(UIEvent *)event {
  	UITouch *myTouch = [touches anyObject];
 	CGPoint point = [myTouch locationInView:[myTouch view]];
 	point = [[CCDirector sharedDirector] convertToGL:point];
  	CCNode *hero = [self getChildByTag:kTagHero];
 	[hero setPosition:point];
   // CCNode *enemy = [self getChildByTag:kTagEnemy];
    CCNode *fireball = [self getChildByTag:kTagFireball];
    /*
  	[enemy runAction:[CCMoveTo
                      actionWithDuration:5.0
                      position:ccp(hero.position.x, hero.position.y)
                      ]];
     */
    [fireball runAction:[CCMoveTo
                      actionWithDuration:3.0
                      position:ccp(hero.position.x, hero.position.y)
                      ]];
  	//return YES;
}

-(id) init {
    
	if( (self=[super init] )) {
        
		CCMenuItem *Pause = [CCMenuItemImage itemFromNormalImage:@"pausebutton.png"
                                                   selectedImage: @"pausebutton.png"
                                                          target:self 
                                                        selector:@selector(pause:)];
		CCMenu *PauseButton = [CCMenu menuWithItems: Pause, nil];
		PauseButton.position = ccp(25, 295);
		[self addChild:PauseButton z:1000];
        self.isTouchEnabled = YES;
        
        // Creates the hero and assigns it to kTagHero
        CCSprite *hero = [CCSprite
                          spriteWithFile:@"hero.png"];
		hero.position = ccp(250, 160);
		[self addChild:hero z:2 tag:kTagHero];
        
        // creates the enemy and assigns it to kTagEnemy
		CCSprite *enemy = [CCSprite
                           spriteWithFile:@"enemy.png"];
		enemy.position = ccp(430, 160);
		[self addChild:enemy z:1 tag:kTagEnemy];
        /*
        // Makes the enemy move
		[enemy runAction:[CCMoveTo
                          actionWithDuration:5.0
                          position:ccp(hero.position.x,
                                       hero.position.y)
                          ]];
         */
        
        
        
        
        
        
      
        
        
		[self schedule:@selector(SpritesDidColide)
              interval:.01];
        [self schedule:@selector(fire) interval:1.0];        
        	}
	return self;
}

-(void) fire {
    
    CCNode *hero = [self getChildByTag:kTagHero];
    // cache
    CCSpriteFrameCache *cache=[CCSpriteFrameCache sharedSpriteFrameCache];
    [cache addSpriteFramesWithFile:@"fireballs.plist"];
    
    //frame array
    NSMutableArray *framesArray=[NSMutableArray array];
    for (int i=0; i<4; i++) {
        NSString *frameName=[NSString stringWithFormat:@"Frame%d.png",i];
        id frameObject=[cache spriteFrameByName:frameName];
        [framesArray addObject:frameObject];
    }
    
    // animation object
    id animObject=[CCAnimation animationWithFrames:framesArray delay:0.1];
    
    //animation action
    id animAction=[CCAnimate actionWithAnimation:animObject restoreOriginalFrame:NO];
    animAction = [CCRepeatForever actionWithAction:animAction];
    
    
    
    // sprite 1
    CCSprite *fireball=[CCSprite spriteWithSpriteFrameName:@"Frame0.png"];
    //[self addChild:fireball z:3 tag:kTagFireball];
    [self addChild:fireball z:3 tag:kTagFireball];
    [fireball runAction:animAction];
    float w = 25;
    fireball.position = ccp(400+w,160);
    
    //action 1
    [fireball runAction:[CCMoveTo
                         actionWithDuration:3.0
                         position:ccp(hero.position.x, hero.position.y)
                         ]];
    }

-(void) pause: (id) sender {
    
	[[CCDirector sharedDirector] pushScene:[PauseScene node]];
}

-(void) SpritesDidColide {
    
	CCNode *enemy = [self getChildByTag:kTagFireball];
	CCNode *hero = [self getChildByTag:kTagHero];
    //CCNode *fireball = [self getChildByTag:kTagFireball];
    
	float xDif = enemy.position.x - hero.position.x;
	float yDif = enemy.position.y - hero.position.y;
	float distance = sqrt(xDif * xDif + yDif * yDif);
    
	if (distance < 20) {
		[self unschedule:@selector(SpritesDidColide)];
		[[CCDirector sharedDirector]
         replaceScene:
         [CCTransitionFade
          transitionWithDuration:1
          scene:[GameOver node]
          ]];
	}

    
    
}




@end
