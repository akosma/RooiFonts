//
//  FontDetailController.m
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright 2008 Adrian Kosmaczewski. All rights reserved.
//

#import "FontDetailController.h"

@interface FontDetailController (Private)
- (void)done:(id)sender;
- (void)clear:(id)sender;
- (void)setFonts;
@end

@implementation FontDetailController

@synthesize fontName;

- (id)init
{
    if (self = [super initWithNibName:@"FontDetail" bundle:nil]) 
    {
        button = [[UIBarButtonItem alloc] initWithTitle:@"Clear"
                                                  style:UIBarButtonItemStylePlain
                                                 target:self 
                                                 action:@selector(clear:)];
        self.navigationItem.rightBarButtonItem = button;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)dealloc
{
    [button release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    UIFont *font = [UIFont fontWithName:self.fontName size:slider.value];
    sampleView.font = font;
    alphabetTextView.font = font;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self done:self];
}

#pragma mark -
#pragma mark UIViewController methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait) ||
            (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||   
            (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)sliderValueChanged:(id)sender
{
    [self setFonts];
    specialSizes.selectedSegmentIndex = -1;
}

- (IBAction)changedDisplayType:(id)sender
{
    if (displayType.selectedSegmentIndex == 0)
    {
        alphabetTextView.hidden = YES;
        sampleView.hidden = NO;
        self.navigationItem.rightBarButtonItem = button;
    }
    else 
    {
        alphabetTextView.hidden = NO;
        sampleView.hidden = YES;
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (IBAction)selectedSpecialSize:(id)sender
{
    CGFloat value = -1.0;
    switch (specialSizes.selectedSegmentIndex) 
    {
        case 0:
        {
            value = [UIFont smallSystemFontSize];
            break;
        }
            
        case 1:
        {
            value = [UIFont systemFontSize];
            break;
        }
            
        case 2:
        {
            value = [UIFont labelFontSize];
            break;
        }

        case 3:
        {
            value = [UIFont buttonFontSize];
            break;
        }
            
        default:
            break;
    }
    if (value != -1.0)
    {
        slider.value = value;
        [self setFonts];
    }
}

#pragma mark -
#pragma mark UITextViewDelegate methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    button.title = @"Done";
    button.action = @selector(done:);
    button.style = UIBarButtonItemStyleDone;
    sampleView.frame = CGRectMake(0.0, 94.0, 320.0, 150.0);
    return TRUE;
}

#pragma mark -
#pragma mark Private methods

- (void)done:(id)sender
{
    button.title = @"Clear";
    button.action = @selector(clear:);
    button.style = UIBarButtonItemStylePlain;
    sampleView.frame = CGRectMake(0.0, 94.0, 320.0, 430.0);
    [sampleView resignFirstResponder];
}

- (void)clear:(id)sender
{
    sampleView.text = @"";
    [sampleView becomeFirstResponder];
}

- (void)setFonts
{
    sizeLabel.text = [NSString stringWithFormat:@"%1.0f pt", slider.value];
    UIFont *font = [UIFont fontWithName:self.fontName size:slider.value];
    sampleView.font = font;
    alphabetTextView.font = font;
}

@end
