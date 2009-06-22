//
//  FontDetailController.m
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontDetailController.h"
#import "SizeController.h"

@interface FontDetailController (Private)
- (void)done:(id)sender;
- (void)clear:(id)sender;
@end

@implementation FontDetailController

@synthesize fontName;

#pragma mark -
#pragma mark Constructors and destructors

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
    sizeController.delegate = nil;
    [sizeController release];
    [button release];
    [super dealloc];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    sizeController = [[SizeController alloc] init];
    sizeController.delegate = self;
    [sizeView addSubview:sizeController.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    UIFont *font = [UIFont fontWithName:self.fontName size:sizeController.size];
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

#pragma mark -
#pragma mark SizeControllerDelegate methods

- (void)sizeController:(SizeController *)sizeController didChangeSize:(CGFloat)newSize
{
    UIFont *font = [UIFont fontWithName:self.fontName size:newSize];
    sampleView.font = font;
    alphabetTextView.font = font;
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

@end
