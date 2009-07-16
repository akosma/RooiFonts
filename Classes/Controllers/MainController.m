//
//  MainController.m
//  FontKit
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "MainController.h"
#import "FontDetailController.h"
#import "UIFont+FontList.h"
#import "AboutController.h"
#import "SizeController.h"

@interface FontsController (Private)
- (void)viewCurrentlySelectedFont;
@end

@implementation MainController

@synthesize controller;

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
    if (self = [super init])
    {
        controller = [[UINavigationController alloc] initWithRootViewController:self];
        controller.toolbarHidden = NO;
        
        _sizeController = [[SizeController alloc] init];
        _sizeController.delegate = self;
        self.tableView.tableHeaderView = _sizeController.view;
        
        self.delegate = self;
        
        UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [aboutButton addTarget:self
                        action:@selector(about:) 
              forControlEvents:UIControlEventTouchDown];
        UIBarButtonItem *aboutItem = [[UIBarButtonItem alloc] initWithCustomView:aboutButton];
        self.navigationItem.rightBarButtonItem = aboutItem;
        [aboutItem release];
        
        UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
                                                                                      target:self
                                                                                      action:@selector(action:)];
        UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                                        target:nil 
                                                                                        action:nil];
        UIBarButtonItem *flexibleSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                                        target:nil 
                                                                                        action:nil];
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil 
                                                                                    action:nil];
        fixedSpace.width = 20;
        
        NSArray *viewsOptions = [[NSArray alloc] initWithObjects:@"Names", @"Samples", nil];
        UISegmentedControl *viewsControl = [[UISegmentedControl alloc] initWithItems:viewsOptions];
        viewsControl.segmentedControlStyle = UISegmentedControlStyleBar;
        [viewsControl addTarget:self
                         action:@selector(changeView:) 
               forControlEvents:UIControlEventValueChanged];
        viewsControl.selectedSegmentIndex = 0;
        [viewsOptions release];
        UIBarButtonItem *viewsItem = [[UIBarButtonItem alloc] initWithCustomView:viewsControl];
        [viewsControl release];
        
        NSArray *items = [[NSArray alloc] initWithObjects:actionButton, flexibleSpace1, viewsItem, flexibleSpace2, fixedSpace, nil];
        [viewsItem release];
        [fixedSpace release];
        [flexibleSpace1 release];
        [flexibleSpace2 release];
        [actionButton release];

        self.toolbarItems = items;
        [items release];
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    [controller release];
    [detailController release];
    [aboutBox release];
    [super dealloc];
}

#pragma mark -
#pragma mark IBAction methods

- (void)changeView:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    self.showScrollingFonts = (control.selectedSegmentIndex == 1);
    [self.tableView reloadData];
}

- (void)about:(id)sender
{
    if (aboutBox == nil)
    {
        aboutBox = [[AboutController alloc] init];
    }
    [controller pushViewController:aboutBox animated:YES];
}

- (void)action:(id)sender
{
    toolbarActionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                     delegate:self 
                                            cancelButtonTitle:@"Cancel"
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:@"Copy list", @"Send list via e-mail", nil];
    [toolbarActionSheet showInView:controller.view];
    [toolbarActionSheet release];
}

#pragma mark -
#pragma mark FontsControllerDelegate methods

- (void)fontsController:(FontsController *)controller rowSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    [self viewCurrentlySelectedFont];
}

#pragma mark -
#pragma mark UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            UIPasteboard *board = [UIPasteboard generalPasteboard];
            board.string = [UIFont fontList];
            break;
        }
            
        case 1:
        {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            [picker setMessageBody:[UIFont fontList] isHTML:NO];
            [self presentModalViewController:picker animated:YES];
            [picker release];        
            break;
        }
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark SizeControllerDelegate methods

- (void)sizeController:(SizeController *)sizeController didChangeSize:(CGFloat)newSize
{
    self.fontHeight = newSize;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController *)composer 
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError *)error
{
    [composer dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIViewController methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning 
{
    [aboutBox release];
    aboutBox = nil;
    [detailController release];
    detailController = nil;
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Private methods

- (void)viewCurrentlySelectedFont
{
    if (detailController == nil)
    {
        detailController = [[FontDetailController alloc] init];
    }
    detailController.fontName = self.currentlySelectedFontName;
    detailController.fontFamilyName = self.currentlySelectedFontFamily;
    detailController.title = self.currentlySelectedFontName;
    [self.controller pushViewController:detailController animated:YES];
}

@end
