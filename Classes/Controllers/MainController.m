//
//  MainController.m
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "MainController.h"
#import "FontDetailController.h"
#import "UIFont+FontList.h"
#import "AboutController.h"

@interface MainController ()

@property (nonatomic, retain) UIActionSheet *toolbarActionSheet;
@property (nonatomic, retain) AboutController *aboutBox;
@property (nonatomic, retain) FontDetailController *detailController;

- (void)viewCurrentlySelectedFont;

@end

@implementation MainController

@synthesize controller = _controller;
@synthesize aboutBox = _aboutBox;
@synthesize toolbarActionSheet = _toolbarActionSheet;
@synthesize detailController = _detailController;

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
    if (self = [super init])
    {
        self.controller = [[[UINavigationController alloc] initWithRootViewController:self] autorelease];
        self.controller.navigationBar.barStyle = UIBarStyleBlackOpaque;
        self.controller.toolbarHidden = NO;
        self.controller.toolbar.barStyle = UIBarStyleBlackOpaque;
        
        self.delegate = self;
        
        UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [aboutButton addTarget:self
                        action:@selector(about:) 
              forControlEvents:UIControlEventTouchDown];
        UIBarButtonItem *aboutItem = [[[UIBarButtonItem alloc] initWithCustomView:aboutButton] autorelease];
        self.navigationItem.rightBarButtonItem = aboutItem;
        
        UIBarButtonItem *actionButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
                                                                                       target:self
                                                                                       action:@selector(action:)] autorelease];
        
        NSArray *items = [NSArray arrayWithObject:actionButton];
        self.toolbarItems = items;
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    self.controller = nil;
    self.toolbarActionSheet = nil;
    self.aboutBox = nil;
    self.detailController = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark IBAction methods

- (void)about:(id)sender
{
    if (self.aboutBox == nil)
    {
        self.aboutBox = [[[AboutController alloc] init] autorelease];
    }
    [self presentModalViewController:self.aboutBox animated:YES];
}

- (void)action:(id)sender
{
    if (self.toolbarActionSheet == nil)
    {
        NSString *copyListEntry = NSLocalizedString(@"Copy list", 
                                                    @"'Copy list' entry of the action menu in the MainController class");
        NSString *sendMailEntry = NSLocalizedString(@"Send list via e-mail", 
                                                    @"'Send list via e-mail' entry of the action menu in the MainController class");
        NSString *cancelButtonText = NSLocalizedString(@"Cancel", 
                                                       @"'Cancel' button in action menus");
        
        self.toolbarActionSheet = [[[UIActionSheet alloc] initWithTitle:@""
                                                               delegate:self 
                                                      cancelButtonTitle:cancelButtonText
                                                 destructiveButtonTitle:nil
                                                      otherButtonTitles:copyListEntry, sendMailEntry, nil] autorelease];
    }
    [self.toolbarActionSheet showInView:self.controller.view];
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
    if (actionSheet == self.toolbarActionSheet)
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
    return YES;
}

- (void)didReceiveMemoryWarning 
{
    self.aboutBox = nil;
    self.toolbarActionSheet = nil;
    self.detailController = nil;
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Private methods

- (void)viewCurrentlySelectedFont
{
    if (self.detailController == nil)
    {
        self.detailController = [[FontDetailController alloc] init];
    }
    self.detailController.fontName = self.currentlySelectedFontName;
    self.detailController.fontFamilyName = self.currentlySelectedFontFamily;
    self.detailController.title = self.currentlySelectedFontName;
    [self.controller pushViewController:self.detailController animated:YES];
}

@end
