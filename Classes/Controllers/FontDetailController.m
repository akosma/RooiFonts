//
//  FontDetailController.m
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontDetailController.h"
#import "SizeController.h"
#import <QuartzCore/QuartzCore.h>
#import "ComparisonPromptController.h"

@interface FontDetailController (Private)
- (UIImage *)createScreenshot;
@end

@implementation FontDetailController

@synthesize fontName;
@synthesize fontFamilyName;

#pragma mark -
#pragma mark Constructors and destructors

- (id)init
{
    if (self = [super initWithNibName:@"FontDetail" bundle:nil]) 
    {
        self.hidesBottomBarWhenPushed = YES;
        comparativeTexts = [[NSArray alloc] initWithObjects:@"abcdefghijklmnopqrstuvwxyz\nABCDEFGHIJKLMNOPQRSTUVWXYZ\n1234567890\n!@#$%^&*()_-+={}[];'\\:\"|<>?,./",
                            @"The quick brown fox jumps over a lazy dog.", 
                            @"Zwei Boxkämpfer jagen Eva quer durch Sylt.",
                            @"Pchnąć w tę łódź jeża lub osiem skrzyń fig. Żywioł, jaźń, Świerk.", 
                            @"Flygande bäckasiner söka strax hwila på mjuka tuvor.",
                            @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", nil];
    }
    return self;
}

- (void)dealloc
{
    sizeController.delegate = nil;
    [sizeController release];
    [comparativeTexts release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController methods

- (void)viewDidLoad 
{
    [super viewDidLoad];
    sizeController = [[SizeController alloc] init];
    sizeController.delegate = self;
    [sizeView addSubview:sizeController.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    UIFont *font = [UIFont fontWithName:self.fontName size:sizeController.size];
    sampleView.font = font;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self done:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)done:(id)sender
{
    self.navigationItem.rightBarButtonItem = nil;
    editButton.title = @"Clear";
    editButton.action = @selector(clear:);
    editButton.style = UIBarButtonItemStylePlain;
    sampleView.frame = CGRectMake(0.0, 58.0, 320.0, 430.0);
    [sampleView resignFirstResponder];
}

- (IBAction)clear:(id)sender
{
    editButton.title = @"Done";
    editButton.action = @selector(done:);
    editButton.style = UIBarButtonItemStyleDone;
    self.navigationItem.rightBarButtonItem = editButton;
    [sampleView becomeFirstResponder];
}

- (IBAction)action:(id)sender
{
    otherActionsSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                    delegate:self 
                                           cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:@"Screenshot via e-mail", @"Copy name", @"Compare with...", nil];
    [otherActionsSheet showInView:self.navigationController.view];
    [otherActionsSheet release];
}

- (IBAction)showComparativeTexts:(id)sender
{
    textsActionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                    delegate:self 
                                           cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:nil];
    for (NSString *text in comparativeTexts)
    {
        NSString *buttonTitle = [NSString stringWithFormat:@"%@...", [text substringToIndex:20]];
        [textsActionSheet addButtonWithTitle:buttonTitle];
    }
    [textsActionSheet addButtonWithTitle:@"Cancel"];
    textsActionSheet.cancelButtonIndex = [comparativeTexts count];
    [textsActionSheet showInView:self.navigationController.view];
    [textsActionSheet release];
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
#pragma mark SizeControllerDelegate methods

- (void)sizeController:(SizeController *)sizeController didChangeSize:(CGFloat)newSize
{
    UIFont *font = [UIFont fontWithName:self.fontName size:newSize];
    sampleView.font = font;
}

#pragma mark -
#pragma mark UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == otherActionsSheet)
    {
        switch (buttonIndex) 
        {
            case 0:
            {
                UIImage *image = [self createScreenshot];
                MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
                picker.mailComposeDelegate = self;

                NSMutableString *message = [[NSMutableString alloc] init];
                [message appendFormat:@"This is how %@ at %1.0f pt looks on the iPhone\n\nSent from FontKit - http://fontkitapp.com/", self.fontName, sizeController.size];
                NSString *subject = [NSString stringWithFormat:@"%@ screenshot", self.fontName];
                [picker setSubject:subject];
                [picker setMessageBody:message isHTML:NO];
                [picker addAttachmentData:UIImagePNGRepresentation(image) mimeType:@"image/png" fileName:@"image"];
                [self presentModalViewController:picker animated:YES];
                [picker release];
                [message release];
                break;
            }

            case 1:
            {
                UIPasteboard *board = [UIPasteboard generalPasteboard];
                board.string = [NSString stringWithFormat:@"Family: %@; font: %@", self.fontFamilyName, self.fontName];
                break;
            }
                
            case 2:
            {
                ComparisonPromptController *comparisonPrompt = [[ComparisonPromptController alloc] init];
                comparisonPrompt.title = self.fontName;
                [self.navigationController pushViewController:comparisonPrompt animated:YES];
                [comparisonPrompt release];
                break;
            }
                
            default:
                break;
        }
    }
    else if (actionSheet == textsActionSheet)
    {
        if (buttonIndex < [comparativeTexts count])
        {
            sampleView.text = [comparativeTexts objectAtIndex:buttonIndex];
        }
    }
}

#pragma mark -
#pragma mark UITextViewDelegate methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    sampleView.frame = CGRectMake(0.0, 58.0, 320.0, 150.0);
    return TRUE;
}

#pragma mark -
#pragma mark Private methods

- (UIImage *)createScreenshot
{
    // This code comes from 
    // http://idevkit.com/forums/tutorials-code-samples-sdk/5-uiimage-any-calayer-uiview.html
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    // To remove the warning (missing renderInContext: method), add 
    // #import <QuartzCore/QuartzCore.h>
    // at the top of the file.
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // UIImageWriteToSavedPhotosAlbum(viewImage, self, nil, nil);
    return viewImage;
}

@end
