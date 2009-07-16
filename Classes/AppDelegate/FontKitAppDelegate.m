//
//  FontKitAppDelegate.m
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontKitAppDelegate.h"
#import "MainController.h"

@implementation FontKitAppDelegate

@synthesize comparativeTexts = _comparativeTexts;

+ (FontKitAppDelegate *)sharedAppDelegate
{
    return (FontKitAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)dealloc 
{
    [_viewController release];
    [_window release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIApplicationDelegate methods

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    _viewController = [[MainController alloc] init];

    _comparativeTexts = [[NSArray alloc] initWithObjects:@"abcdefghijklmnopqrstuvwxyz\nABCDEFGHIJKLMNOPQRSTUVWXYZ\n1234567890\n!@#$%^&*()_-+={}[];'\\:\"|<>?,./",
                        @"The quick brown fox jumps over a lazy dog.", 
                        @"Zwei Boxkämpfer jagen Eva quer durch Sylt.",
                        @"Pchnąć w tę łódź jeża lub osiem skrzyń fig. Żywioł, jaźń, Świerk.", 
                        @"Flygande bäckasiner söka strax hwila på mjuka tuvor.",
                        @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", nil];
    
    [_window addSubview:_viewController.controller.view];
    [_window makeKeyAndVisible];
}

@end
