//
//  RFComparisonPromptController.m
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "RFComparisonPromptController.h"
#import "RFComparisonDetailController.h"

@interface RFComparisonPromptController ()

@property (nonatomic, retain) RFComparisonDetailController *comparisonController;

@end


@implementation RFComparisonPromptController

@synthesize comparisonController = _comparisonController;
@synthesize topFontName = _topFontName;

- (void)dealloc
{
    [_topFontName release];
    [_comparisonController release];
    [super dealloc];
}

#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *prompt = NSLocalizedString(@"Select a font to compare with", 
                                         @"Prompts the user to choose another font");
    self.navigationItem.prompt = prompt;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    self.comparisonController = nil;
}

#pragma mark - FontsControllerDelegate methods

- (void)fontsController:(RFFontsController *)controller rowSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.comparisonController == nil)
    {
        self.comparisonController = [[[RFComparisonDetailController alloc] init] autorelease];
    }
    self.comparisonController.topFontName = self.topFontName;
    self.comparisonController.bottomFontName = self.currentlySelectedFontName;
    [self.navigationController pushViewController:self.comparisonController animated:YES];
}

@end
