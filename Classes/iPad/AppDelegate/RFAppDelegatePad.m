//
//  RFAppDelegatePad.m
//  RooiFonts
//
//  Created by Adrian on 9/15/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import "RFAppDelegatePad.h"
#import "RFMainController.h"


@implementation RFAppDelegatePad

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
