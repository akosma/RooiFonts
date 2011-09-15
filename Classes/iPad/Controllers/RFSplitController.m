//
//  RFSplitController.m
//  RooiFonts
//
//  Created by Adrian on 9/15/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import "RFSplitController.h"
#import "RFFontDetailControllerPad.h"
#import "RFFontsController.h"

@interface RFSplitController ()

@property (nonatomic, retain) UIPopoverController *popoverController;

- (void)viewCurrentlySelectedFont;

@end


@implementation RFSplitController

@synthesize detailController = _detailController;
@synthesize fontsController = _fontsController;
@synthesize popoverController = _myPopoverController;

- (void)dealloc
{
    [_fontsController release];
    [_detailController release];
    [_myPopoverController release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - UISplitViewControllerDelegate methods

- (void)splitViewController:(UISplitViewController *)svc 
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController: (UIPopoverController *)pc
{
    barButtonItem.title = @"RooiFonts";
    NSMutableArray *items = [[self.detailController.toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.detailController.toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSMutableArray *items = [[self.detailController.toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [self.detailController.toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}

#pragma mark - FontsControllerDelegate methods

- (void)fontsController:(RFFontsController *)controller rowSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    [self viewCurrentlySelectedFont];
}

#pragma mark - Private methods

- (void)viewCurrentlySelectedFont
{
    self.detailController.fontName = self.fontsController.currentlySelectedFontName;
    self.detailController.fontFamilyName = self.fontsController.currentlySelectedFontFamily;
    [self.detailController refresh];
    [self.popoverController dismissPopoverAnimated:YES];
}

@end
