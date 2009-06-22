//
//  FontDetailController.h
//  FontKit
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
    IBOutlet UITextView *sampleView;
    IBOutlet UIView *sizeView;
    IBOutlet UIBarButtonItem *editButton;
    UIActionSheet *textsActionSheet;
    UIActionSheet *otherActionsSheet;
    SizeController *sizeController;
    NSString *fontName;
    NSString *fontFamilyName;
    NSArray *comparativeTexts;
}

@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, copy) NSString *fontFamilyName;

- (IBAction)action:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)showComparativeTexts:(id)sender;

@end
