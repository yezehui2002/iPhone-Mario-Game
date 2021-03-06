//
//  HelloWorldLayer.m
//  FirstGame2
//
//  Created by Andres on 5/17/11.
//  Copyright Kennesaw State University 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "GamePlay.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        CCSprite *bg = [CCSprite spriteWithFile:@"screenshot_01.png"];
        bg.anchorPoint = ccp(0, 0);
        bg.position = ccp(0, 0);
        [self addChild:bg z:0];
		
		// always call “super” init
        // Apple recommends to re-assign “self” with the “super” return value
        
            [CCMenuItemFont setFontName:@"Marker Felt"];
            [CCMenuItemFont setFontSize:35];
            CCMenuItem *Play = [CCMenuItemFont itemFromString:@"Play" target:self selector:@selector(goToGameplay:)];
            CCMenu *menu = [CCMenu menuWithItems: Play, nil];
            menu.position = ccp(240, 160);
            [menu alignItemsVerticallyWithPadding:10];
            [self addChild:menu];
        
        
        
        }
	return self;
}

-(void) goToGameplay: (id) sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GamePlay node]]];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
