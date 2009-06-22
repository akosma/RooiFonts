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
        
        NSArray *items = [[NSArray alloc] initWithObjects:actionButton, nil];
        self.toolbarItems = items;
        [actionButton release];
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
