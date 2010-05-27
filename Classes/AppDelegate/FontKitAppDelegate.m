//
//  FontKitAppDelegate.m
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontKitAppDelegate.h"
#import "MainController.h"

@interface FontKitAppDelegate ()

@property (nonatomic, retain) MainController *viewController;

@end


@implementation FontKitAppDelegate

@synthesize splitViewController = _splitViewController;
@synthesize window = _window;
@synthesize viewController = _viewController;
@dynamic userInterfaceIdiomPad;

- (void)dealloc 
{
    self.splitViewController = nil;
    self.viewController = nil;
    self.window = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UIApplicationDelegate methods

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    if (self.userInterfaceIdiomPad)
    {
        [self.window addSubview:[self.splitViewController view]];
    }
    else
    {
        self.viewController = [[[MainController alloc] init] autorelease];
        [self.window addSubview:self.viewController.controller.view];
    }
    [self.window makeKeyAndVisible];
}

#pragma mark -
#pragma mark Private methods

- (BOOL)userInterfaceIdiomPad
{
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
    // Adapted from
    // http://stackoverflow.com/questions/2576356/how-does-one-get-ui-user-interface-idiom-to-work-with-iphone-os-sdk-3-2
    if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)])
    {
        return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
    }
#endif
    return NO;
}

@end
