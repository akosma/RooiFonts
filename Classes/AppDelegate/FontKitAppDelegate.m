//
//  FontKitAppDelegate.m
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontKitAppDelegate.h"
#import "MainController.h"

@implementation FontKitAppDelegate

- (void)dealloc 
{
    [viewController release];
    [window release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIApplicationDelegate methods

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    viewController = [[MainController alloc] init];

    [window addSubview:viewController.controller.view];
    [window makeKeyAndVisible];
}

@end
