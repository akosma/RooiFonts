//
//  ComparisonPromptController.m
//  FontKit
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "ComparisonPromptController.h"
#import "ComparisonDetailController.h"

@implementation ComparisonPromptController

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
    if (self = [super init])
    {
        self.navigationItem.prompt = @"Select a font to compare with";
        self.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning 
{
    [comparisonController release];
    comparisonController = nil;
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark FontsControllerDelegate methods

- (void)fontsController:(FontsController *)controller rowSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    if (comparisonController == nil)
    {
        comparisonController = [[ComparisonDetailController alloc] init];
    }
    comparisonController.topFontName = self.title;
    comparisonController.bottomFontName = self.currentlySelectedFontName;
    [self.navigationController pushViewController:comparisonController animated:YES];
}

@end
