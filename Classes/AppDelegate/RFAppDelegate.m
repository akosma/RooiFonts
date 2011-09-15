//
//  RFAppDelegate.m
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "RFAppDelegate.h"
#import "RFMainController.h"


@implementation RFAppDelegate

@synthesize window = _window;
@synthesize mainController = _mainController;

- (void)dealloc 
{
    [_mainController release];
    [_window release];
    [super dealloc];
}

#pragma mark - UIApplicationDelegate methods

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    self.window.rootViewController = self.mainController;
    [self.window makeKeyAndVisible];
}

@end
