//
//  RFFontDetailControllerPad.m
//  RooiFonts
//
//  Created by Adrian on 9/15/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import "RFFontDetailControllerPad.h"


@implementation RFFontDetailControllerPad

@synthesize toolbar = _toolbar;
@synthesize actionButtonItem = _actionButtonItem;
@synthesize textButtonItem = _textButtonItem;

- (void)dealloc
{
    [_toolbar release];
    [_actionButtonItem release];
    [_textButtonItem release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Overridden methods

- (void)showActionSheet
{
    [self.otherActionsSheet showFromBarButtonItem:self.actionButtonItem 
                                         animated:YES];
}

- (void)showTextsSheet
{
    [self.textsActionSheet showFromBarButtonItem:self.textButtonItem 
                                        animated:YES];
}

@end
