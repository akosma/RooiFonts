//
//  ComparisonDetailController.m
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "ComparisonDetailController.h"
#import "SizeController.h"

@interface ComparisonDetailController ()

@property (nonatomic, retain) SizeController *sizeController;

@end


@implementation ComparisonDetailController

@synthesize topFontName = _topFontName;
@synthesize bottomFontName = _bottomFontName;
@synthesize sizeView = _sizeView;
@synthesize topView = _topView;
@synthesize bottomView = _bottomView;
@synthesize sizeController = _sizeController;

#pragma mark -
#pragma mark Constructors and destructors

- (id)init
{
    if (self = [super initWithNibName:@"ComparisonDetail" bundle:nil]) 
    {
        self.sizeController = [[[SizeController alloc] init] autorelease];
        self.sizeController.delegate = self;
    }
    return self;
}

- (void)dealloc 
{
    self.sizeController.delegate = nil;
    self.sizeController = nil;
    self.topFontName = nil;
    self.bottomFontName = nil;
    self.sizeView = nil;
    self.topView = nil;
    self.bottomView = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark SizeControllerDelegate methods

- (void)sizeController:(SizeController *)sizeController didChangeSize:(CGFloat)newSize
{
    UIFont *topFont = [UIFont fontWithName:self.topFontName size:newSize];
    UIFont *bottomFont = [UIFont fontWithName:self.bottomFontName size:newSize];
    self.topView.font = topFont;
    self.bottomView.font = bottomFont;
}

#pragma mark -
#pragma mark UIViewController methods

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
    [self.sizeView addSubview:self.sizeController.view];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

@end
