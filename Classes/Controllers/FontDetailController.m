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

@interface FontDetailController (Private)
- (void)done:(id)sender;
- (void)clear:(id)sender;
- (UIImage *)createScreenshot;
@end

@implementation FontDetailController

@synthesize fontName;

#pragma mark -
#pragma mark Constructors and destructors

- (id)init
{
    if (self = [super initWithNibName:@"FontDetail" bundle:nil]) 
    {
        button = [[UIBarButtonItem alloc] initWithTitle:@"Clear"
                                                  style:UIBarButtonItemStylePlain
                                                 target:self 
                                                 action:@selector(clear:)];
        self.navigationItem.rightBarButtonItem = button;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)dealloc
{
    sizeController.delegate = nil;
    [sizeController release];
    [button release];
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
    alphabetTextView.font = font;
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

- (IBAction)changedDisplayType:(id)sender
{
    if (displayType.selectedSegmentIndex == 0)
    {
        alphabetTextView.hidden = YES;
        sampleView.hidden = NO;
        self.navigationItem.rightBarButtonItem = button;
    }
    else 
    {
        alphabetTextView.hidden = NO;
        sampleView.hidden = YES;
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (IBAction)action:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@""
                                                       delegate:self 
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Screenshot via e-mail", nil];
    [sheet showInView:self.navigationController.view];
    [sheet release];
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
    alphabetTextView.font = font;
}

#pragma mark -
#pragma mark UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        UIImage *image = [self createScreenshot];
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        NSMutableString *message = [[NSMutableString alloc] init];
        [message appendFormat:@"This is how %@ at %1.0f points looks like on the iPhone\n\nSent from FontKit - http://fontkitapp.com/", self.fontName, sizeController.size];
        NSString *subject = [NSString stringWithFormat:@"%@ screenshot", self.fontName];
        [picker setSubject:subject];
        [picker setMessageBody:message isHTML:NO];
        [picker addAttachmentData:UIImagePNGRepresentation(image) mimeType:@"image/png" fileName:@"image"];
        [self presentModalViewController:picker animated:YES];
        [picker release];
        [message release];
    }
}

#pragma mark -
#pragma mark UITextViewDelegate methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    button.title = @"Done";
    button.action = @selector(done:);
    button.style = UIBarButtonItemStyleDone;
    sampleView.frame = CGRectMake(0.0, 94.0, 320.0, 150.0);
    return TRUE;
}

#pragma mark -
#pragma mark Private methods

- (void)done:(id)sender
{
    button.title = @"Clear";
    button.action = @selector(clear:);
    button.style = UIBarButtonItemStylePlain;
    sampleView.frame = CGRectMake(0.0, 94.0, 320.0, 430.0);
    [sampleView resignFirstResponder];
}

- (void)clear:(id)sender
{
    sampleView.text = @"";
    [sampleView becomeFirstResponder];
}

- (UIImage *)createScreenshot
{
    // This code comes from 
    // http://idevkit.com/forums/tutorials-code-samples-sdk/5-uiimage-any-calayer-uiview.html
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    // To remove the warning, add 
    // #import <QuartzCore/QuartzCore.h>
    // at the top of the file. Done!
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    UIImageWriteToSavedPhotosAlbum(viewImage, self, nil, nil);
    return viewImage;
}

@end
