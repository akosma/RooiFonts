//
//  RFComparisonDetailController.m
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "RFComparisonDetailController.h"
#import "RFSizeController.h"

@interface RFComparisonDetailController ()

@property (nonatomic, retain) RFSizeController *sizeController;

@end


@implementation RFComparisonDetailController

@synthesize topFontName = _topFontName;
@synthesize bottomFontName = _bottomFontName;
@synthesize sizeView = _sizeView;
@synthesize topView = _topView;
@synthesize bottomView = _bottomView;
@synthesize sizeController = _sizeController;

- (void)dealloc 
{
    _sizeController.delegate = nil;
    [_sizeController release];
    [_topFontName release];
    [_bottomFontName release];
    [_sizeView release];
    [_topView release];
    [_bottomView release];
    [super dealloc];
}

#pragma mark - SizeControllerDelegate methods

- (void)sizeController:(RFSizeController *)sizeController didChangeSize:(CGFloat)newSize
{
    UIFont *topFont = [UIFont fontWithName:self.topFontName size:newSize];
    UIFont *bottomFont = [UIFont fontWithName:self.bottomFontName size:newSize];
    self.topView.font = topFont;
    self.bottomView.font = bottomFont;
}

#pragma mark - UIViewController methods

- (void)viewWillAppear:(BOOL)animated
{
    UIFont *topFont = [UIFont fontWithName:self.topFontName size:self.sizeController.size];
    UIFont *bottomFont = [UIFont fontWithName:self.bottomFontName size:self.sizeController.size];
    self.topView.font = topFont;
    self.bottomView.font = bottomFont;
    
    NSString *comparingWith = NSLocalizedString(@"Comparing %@ with", @"Prompt for the comparison screen");
    self.navigationItem.prompt = [NSString stringWithFormat:comparingWith, self.topFontName];
    self.title = self.bottomFontName;
    NSString *backButtonTitle = NSLocalizedString(@"Back", @"Back button title for the comparison screen");
    self.navigationItem.backBarButtonItem.title = backButtonTitle;
}

- (void)viewDidLoad 
{
    [super viewDidLoad];

    self.sizeController = [[[RFSizeController alloc] init] autorelease];
    self.sizeController.delegate = self;
    [self.sizeView addSubview:self.sizeController.view];
}

@end
