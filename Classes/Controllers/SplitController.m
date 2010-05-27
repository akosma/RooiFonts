//
//  SplitController.m
//  RooiFonts
//
//  Created by Adrian on 5/27/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "SplitController.h"
#import "FontsController.h"
#import "FontDetailController.h"

@implementation SplitController

@synthesize fontsController = _fontsController;
@synthesize fontDetailController = _fontDetailController;

- (void)dealloc 
{
    self.fontsController = nil;
    self.fontDetailController = nil;
    [super dealloc];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return YES;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark FontsControllerDelegate methods

- (void)fontsController:(FontsController *)controller rowSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    self.fontDetailController.fontName = self.fontsController.currentlySelectedFontName;
    self.fontDetailController.fontFamilyName = self.fontsController.currentlySelectedFontFamily;
    [self.fontDetailController refresh];
}

@end
