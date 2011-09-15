//
//  RFFontDetailControllerPad.m
//  RooiFonts
//
//  Created by Adrian on 9/15/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import "RFFontDetailControllerPad.h"
#import "RFSizeController.h"
#import "RFAboutController.h"

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
    self.sizeController.slider.value = 35.0;
    self.sizeController.sizeLabel.text = @"35.0";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Overridden methods

- (void)showActionSheet
{
    [self.textsActionSheet dismissWithClickedButtonIndex:-1 animated:YES];
    [self.otherActionsSheet showFromBarButtonItem:self.actionButtonItem 
                                         animated:YES];
}

- (void)showTextsSheet
{
    [self.otherActionsSheet dismissWithClickedButtonIndex:-1 animated:YES];
    [self.textsActionSheet showFromBarButtonItem:self.textButtonItem 
                                        animated:YES];
}

- (IBAction)clear:(id)sender
{
    [self.textsActionSheet dismissWithClickedButtonIndex:-1 animated:YES];
    [self.otherActionsSheet dismissWithClickedButtonIndex:-1 animated:YES];
    [self.sampleView becomeFirstResponder];
    self.sampleView.text = @"";
}

#pragma mark - Keyboard notification handlers

- (void)shrinkTextView:(NSNotification *)notification
{
    NSDictionary *dict = [notification userInfo];
    NSValue *keyboardFrameValue = [dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect bounds = [keyboardFrameValue CGRectValue];
    
    // Very important in the iPad! 
    // Convert the rectangle from one view to the other!
    bounds = [self.view convertRect:bounds fromView:nil];

    CGFloat origin = self.sampleView.frame.origin.y;
    CGSize size = CGSizeMake(self.sampleView.frame.size.width, fabsf(self.sampleView.frame.size.height - bounds.size.height));
    
    self.sampleView.frame = CGRectMake(0.0, origin, size.width, size.height);
}

- (void)expandTextView:(NSNotification *)notification
{
    CGFloat origin = self.sampleView.frame.origin.y;
    CGSize size = CGSizeMake(self.sampleView.frame.size.width, fabsf(self.view.frame.size.height - origin));
    
    self.sampleView.frame = CGRectMake(0.0, origin, size.width, size.height);
}

@end
