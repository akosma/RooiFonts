//
//  ComparisonPromptController.m
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "ComparisonPromptController.h"
#import "ComparisonDetailController.h"

@interface ComparisonPromptController ()

@property (nonatomic, retain) ComparisonDetailController *comparisonController;

@end


@implementation ComparisonPromptController

@synthesize comparisonController = _comparisonController;

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
    if (self = [super init])
    {
        NSString *prompt = NSLocalizedString(@"Select a font to compare with", 
                                             @"Prompts the user to choose another font");
        self.navigationItem.prompt = prompt;
        self.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    self.comparisonController = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    self.comparisonController = nil;
}

#pragma mark -
#pragma mark FontsControllerDelegate methods

- (void)fontsController:(FontsController *)controller rowSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.comparisonController == nil)
    {
        self.comparisonController = [[[ComparisonDetailController alloc] init] autorelease];
    }
    self.comparisonController.topFontName = self.title;
    self.comparisonController.bottomFontName = self.currentlySelectedFontName;
    [self.navigationController pushViewController:self.comparisonController animated:YES];
}

@end
