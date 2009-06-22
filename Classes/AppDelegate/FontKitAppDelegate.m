//
//  FontKitAppDelegate.m
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright Adrian Kosmaczewski 2008. All rights reserved.
//

#import "FontKitAppDelegate.h"
#import "FontsController.h"

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
    viewController = [[FontsController alloc] init];

    [window addSubview:viewController.controller.view];
    [window makeKeyAndVisible];
}

@end
