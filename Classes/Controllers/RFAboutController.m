//
//  RFAboutController.m
//  RooiFonts
//
//  Created by Adrian on 6/21/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "RFAboutController.h"

@implementation RFAboutController

#pragma mark - IBAction methods

- (IBAction)done:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)akosma:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://akosma.com/"];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)bluewoki:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://bluewoki.com/"];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - UIViewController methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

@end
