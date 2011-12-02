//
//  GameOver.m
//  FirstGame2
//
//  Created by Andres on 5/17/11.
//  Copyright 2011 Kennesaw State University. All rights reserved.
//

#import "GameOver.h"
#import "HelloWorldLayer.h"

@implementation GameOver
+(id) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	GameOver *layer = [GameOver node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

-(id) init
{
    
	if( (self=[super init] )) {
        
		self.isTouchEnabled = YES;
        
		CCLabelAtlas* label = [CCLabelTTF labelWithString:@"Game Over"
                                         fontName:@"Marker Felt"
                                         fontSize:60];
		label.position = ccp(240, 240);
        
		CCLabelAtlas* label2 = [CCLabelTTF labelWithString:@"Touch to go to main menu"
                                          fontName:@"Marker Felt"
                                          fontSize:35];
		label2.position = ccp(240, 131.67f);
        
		[self addChild: label];
		[self addChild: label2];
        
	}
	return self;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
	[[CCDirector sharedDirector]
     replaceScene:[CCTransitionFade
                   transitionWithDuration:1
                   scene:[HelloWorldLayer node]
                   ]];
	//return YES;
}

@end
