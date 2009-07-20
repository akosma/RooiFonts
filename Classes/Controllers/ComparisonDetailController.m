//
//  ComparisonDetailController.m
//  FontKit
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "ComparisonDetailController.h"
#import "SizeController.h"

@implementation ComparisonDetailController

@synthesize topFontName;
@synthesize bottomFontName;

#pragma mark -
#pragma mark Constructors and destructors

- (id)init
{
    if (self = [super initWithNibName:@"ComparisonDetail" bundle:nil]) 
    {
        sizeController = [[SizeController alloc] init];
        sizeController.delegate = self;
    }
    return self;
}

- (void)dealloc 
{
    sizeController.delegate = nil;
    [sizeController release];
    [super dealloc];
}

#pragma mark -
#pragma mark SizeControllerDelegate methods

- (void)sizeController:(SizeController *)sizeController didChangeSize:(CGFloat)newSize
{
    UIFont *topFont = [UIFont fontWithName:topFontName size:newSize];
    UIFont *bottomFont = [UIFont fontWithName:bottomFontName size:newSize];
    topView.font = topFont;
    bottomView.font = bottomFont;
}

#pragma mark -
#pragma mark UIViewController methods

- (void)viewWillAppear:(BOOL)animated
{
    UIFont *topFont = [UIFont fontWithName:topFontName size:sizeController.size];
    UIFont *bottomFont = [UIFont fontWithName:bottomFontName size:sizeController.size];
    topView.font = topFont;
    bottomView.font = bottomFont;
    
    NSString *comparingWith = NSLocalizedString(@"Comparing %@ with", @"Prompt for the comparison screen");
    self.navigationItem.prompt = [NSString stringWithFormat:comparingWith, topFontName];
    self.title = bottomFontName;
    NSString *backButtonTitle = NSLocalizedString(@"Back", @"Back button title for the comparison screen");
    self.navigationItem.backBarButtonItem.title = backButtonTitle;
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    [sizeView addSubview:sizeController.view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

@end
