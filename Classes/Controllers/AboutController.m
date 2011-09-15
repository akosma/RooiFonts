//
//  AboutController.m
//  FontBrowser
//
//  Created by Adrian on 6/21/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "AboutController.h"
#import "RooiFontsAppDelegate.h"

@implementation AboutController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *titleText = NSLocalizedString(@"About RooiFonts", @"Title of the about screen");
    self.title = titleText;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

@end
