//
//  FontDetailController.h
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "SizeControllerDelegate.h"

@class SizeController;

@interface FontDetailController : UIViewController <UITextViewDelegate,
                                                    SizeControllerDelegate,
                                                    UIActionSheetDelegate,
                                                    MFMailComposeViewControllerDelegate>
{
@private
    UITextView *_sampleView;
    UIView *_sizeView;
    UIBarButtonItem *_doneButton;
    UIActionSheet *_textsActionSheet;
    UIActionSheet *_otherActionsSheet;
    SizeController *_sizeController;
    NSString *_fontName;
    NSString *_fontFamilyName;
    NSArray *_comparativeTexts;
}

@property (nonatomic, retain) IBOutlet SizeController *sizeController;
@property (nonatomic, retain) IBOutlet UIView *sizeView;
@property (nonatomic, retain) IBOutlet UITextView *sampleView;
@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, copy) NSString *fontFamilyName;

- (IBAction)action:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)showComparativeTexts:(id)sender;
- (void)refresh;

@end
