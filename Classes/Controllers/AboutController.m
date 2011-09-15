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

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
    if (self = [super initWithNibName:@"About" bundle:nil]) 
    {
        NSString *titleText = NSLocalizedString(@"About RooiFonts", @"Title of the about screen");
        self.title = titleText;
    }
    return self;
}

- (void)dealloc 
{
    [super dealloc];
}

#pragma mark -
#pragma mark IBAction methods

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

#pragma mark -
#pragma mark UIViewController methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [RooiFontsAppDelegate sharedAppDelegate].userInterfaceIdiomPad;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

@end
