//
//  FontBrowserAppDelegate.m
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright Adrian Kosmaczewski 2008. All rights reserved.
//

#import "FontBrowserAppDelegate.h"
#import "FontsController.h"
#import "AboutController.h"

@interface FontBrowserAppDelegate (Private)
- (void)rotateWindowFromView:(UIView *)view1
                      toView:(UIView *)view2
              withTransition:(UIViewAnimationTransition)transition;
@end


@implementation FontBrowserAppDelegate

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
    aboutBox = [[AboutController alloc] init];
    aboutBox.view.frame = CGRectMake(0.0, 20.0, 320.0, 460.0);

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showAboutBox:) 
                                                 name:@"ShowAboutBox" 
                                               object:viewController];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideAboutBox:) 
                                                 name:@"HideAboutBox" 
                                               object:aboutBox];
    
    [window addSubview:viewController.controller.view];
    [window makeKeyAndVisible];
}

- (void)showAboutBox:(NSNotification *)notification
{
    [self rotateWindowFromView:viewController.controller.view
                        toView:aboutBox.view
                withTransition:UIViewAnimationTransitionFlipFromLeft];
}

- (void)hideAboutBox:(NSNotification *)notification
{
    [self rotateWindowFromView:aboutBox.view
                        toView:viewController.controller.view 
                withTransition:UIViewAnimationTransitionFlipFromRight];
}

#pragma mark -
#pragma mark Private methods

- (void)rotateWindowFromView:(UIView *)view1
                      toView:(UIView *)view2
              withTransition:(UIViewAnimationTransition)transition
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.60];
    [UIView setAnimationTransition:transition forView:window cache:YES];
    
    [view1 removeFromSuperview];
    [window addSubview:view2];
    
    [UIView commitAnimations];
}

@end
