//
//  AppDelegate.h
//  FirstGame2
//
//  Created by Andres on 5/17/11.
//  Copyright Kennesaw State University 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
