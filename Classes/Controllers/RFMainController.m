//
//  RFMainController.m
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "RFMainController.h"
#import "RFFontDetailController.h"
#import "UIFont+RooiFonts.h"
#import "RFAboutController.h"

@interface RFMainController ()

@property (nonatomic, retain) UIActionSheet *toolbarActionSheet;
@property (nonatomic, retain) RFAboutController *aboutBox;
@property (nonatomic, retain) RFFontDetailController *detailController;

- (void)viewCurrentlySelectedFont;

@end

@implementation RFMainController

@synthesize aboutBox = _aboutBox;
@synthesize toolbarActionSheet = _toolbarActionSheet;
@synthesize detailController = _detailController;

- (void)dealloc
{
    [_toolbarActionSheet release];
    [_aboutBox release];
    [_detailController release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;

    UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [aboutButton addTarget:self
                    action:@selector(about:) 
          forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *aboutItem = [[[UIBarButtonItem alloc] initWithCustomView:aboutButton] autorelease];
    self.navigationItem.rightBarButtonItem = aboutItem;
}

- (void)didReceiveMemoryWarning 
{
    self.aboutBox = nil;
    self.toolbarActionSheet = nil;
    self.detailController = nil;
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction methods

- (IBAction)about:(id)sender
{
    if (self.aboutBox == nil)
    {
        self.aboutBox = [[[RFAboutController alloc] init] autorelease];
    }
    [self presentModalViewController:self.aboutBox animated:YES];
}

- (IBAction)action:(id)sender
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
    [self.toolbarActionSheet showInView:self.navigationController.view];
}

#pragma mark - FontsControllerDelegate methods

- (void)fontsController:(RFFontsController *)controller rowSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    [self viewCurrentlySelectedFont];
}

#pragma mark - UIActionSheetDelegate methods

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

#pragma mark - MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController *)composer 
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError *)error
{
    [composer dismissModalViewControllerAnimated:YES];
}

#pragma mark - Private methods

- (void)viewCurrentlySelectedFont
{
    if (self.detailController == nil)
    {
        self.detailController = [[[RFFontDetailController alloc] init] autorelease];
        self.detailController.hidesBottomBarWhenPushed = YES;
    }
    self.detailController.fontName = self.currentlySelectedFontName;
    self.detailController.fontFamilyName = self.currentlySelectedFontFamily;
    self.detailController.title = self.currentlySelectedFontName;

    [self.navigationController pushViewController:self.detailController 
                                         animated:YES];
}

@end
