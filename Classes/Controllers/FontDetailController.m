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
- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;
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

        doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                   target:self 
                                                                   action:@selector(done:)];
    }
    return self;
}

- (void)dealloc
{
    sizeController.delegate = nil;
    [sizeController release];
    [doneButton release];
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
    sampleView.frame = CGRectMake(0.0, 58.0, 320.0, 314.0);
    [sampleView resignFirstResponder];
}

- (IBAction)clear:(id)sender
{
    [sampleView becomeFirstResponder];
    sampleView.text = @"";
}

- (IBAction)action:(id)sender
{
    NSString *screenshotOption = NSLocalizedString(@"Screenshot via e-mail", 
                                                   @"'Screenshot' entry of the action menu in the detail screen");
    NSString *copyOption = NSLocalizedString(@"Copy name", 
                                             @"'Copy' entry of the action menu in the detail screen");
    NSString *compareOption = NSLocalizedString(@"Compare with...", 
                                                @"'Compare' option of the action menu in the detail screen");
    NSString *cancelButtonText = NSLocalizedString(@"Cancel", 
                                                @"'Cancel' button in action menus");
    
    otherActionsSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                    delegate:self 
                                           cancelButtonTitle:cancelButtonText
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:screenshotOption, copyOption, compareOption, nil];
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

    NSString *cancelButtonText = NSLocalizedString(@"Cancel", 
                                                   @"'Cancel' button in action menus");

    [textsActionSheet addButtonWithTitle:cancelButtonText];
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
                NSString *messageBody = NSLocalizedString(@"EMAIL_GREETING", @"Text sent via e-mail, below the font image.");
                [message appendFormat:messageBody, self.fontName, sizeController.size];
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
                NSString *textToCopy = NSLocalizedString(@"Family: %@; font: %@", @"Text to be copied in the pasteboard");
                board.string = [NSString stringWithFormat:textToCopy, self.fontFamilyName, self.fontName];
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
    self.navigationItem.rightBarButtonItem = doneButton;
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
    
    // Save to local photo album
    UIImageWriteToSavedPhotosAlbum(viewImage, self, nil, nil);
    
    // Crop image to remove UI widgets and return
    CGRect rect = CGRectMake(0.0, 90.0, 320.0, 280.0);
    return [self imageByCropping:viewImage toRect:rect];
}

// This code comes from 
// http://www.hive05.com/2008/11/crop-an-image-using-the-iphone-sdk/
- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    //create a context to do our clipping in
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //create a rect with the size we want to crop the image to
    //the X and Y here are zero so we start at the beginning of our
    //newly created context
    CGRect clippedRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    CGContextClipToRect( currentContext, clippedRect);
    
    //create a rect equivalent to the full size of the image
    //offset the rect by the X and Y we want to start the crop
    //from in order to cut off anything before them
    CGRect drawRect = CGRectMake(rect.origin.x * -1,
                                 rect.origin.y * -1,
                                 imageToCrop.size.width,
                                 imageToCrop.size.height);

    // This fix comes from one of the comments in page where this
    // code was copied from...
    CGContextTranslateCTM(currentContext, 0.0, rect.size.height);
    CGContextScaleCTM(currentContext, 1.0, -1.0);

    //draw the image to our clipped context using our offset rect
    CGContextDrawImage(currentContext, drawRect, imageToCrop.CGImage);
    
    //pull the image from our cropped context
    UIImage *cropped = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    //Note: this is autoreleased
    return cropped;
}

@end
