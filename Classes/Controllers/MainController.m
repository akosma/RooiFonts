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
<<<<<<< HEAD
#import "SizeController.h"
=======
#import "RooiFontsAppDelegate.h"

@interface MainController ()

@property (nonatomic, retain) UIActionSheet *toolbarActionSheet;
@property (nonatomic, retain) AboutController *aboutBox;
@property (nonatomic, retain) FontDetailController *detailController;
>>>>>>> standard

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
        
        _sizeController = [[SizeController alloc] init];
        _sizeController.delegate = self;
        self.tableView.tableHeaderView = _sizeController.view;
        
        self.delegate = self;
        
        UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [aboutButton addTarget:self
                        action:@selector(about:) 
              forControlEvents:UIControlEventTouchDown];
        UIBarButtonItem *aboutItem = [[[UIBarButtonItem alloc] initWithCustomView:aboutButton] autorelease];
        self.navigationItem.rightBarButtonItem = aboutItem;
        
<<<<<<< HEAD
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
=======
        UIBarButtonItem *actionButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
                                                                                       target:self
                                                                                       action:@selector(action:)] autorelease];
        
        NSArray *items = [NSArray arrayWithObject:actionButton];
        self.toolbarItems = items;
>>>>>>> standard
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

- (void)changeView:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    self.showScrollingFonts = (control.selectedSegmentIndex == 1);
    [self.tableView reloadData];
}

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
    return [RooiFontsAppDelegate sharedAppDelegate].userInterfaceIdiomPad;
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
        self.detailController = [[FontDetailController alloc] initWithNibName:@"FontDetail" bundle:nil];
        self.detailController.hidesBottomBarWhenPushed = YES;
    }
    self.detailController.fontName = self.currentlySelectedFontName;
    self.detailController.fontFamilyName = self.currentlySelectedFontFamily;
    self.detailController.title = self.currentlySelectedFontName;
    [self.controller pushViewController:self.detailController animated:YES];
}

@end
