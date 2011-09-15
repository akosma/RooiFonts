//
//  RFFontDetailController.h
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "RFSizeControllerDelegate.h"

@class RFSizeController;

@interface RFFontDetailController : UIViewController <UITextViewDelegate,
                                                      RFSizeControllerDelegate,
                                                      UIActionSheetDelegate,
                                                      MFMailComposeViewControllerDelegate>

@property (nonatomic, retain) IBOutlet RFSizeController *sizeController;
@property (nonatomic, retain) IBOutlet UIView *sizeView;
@property (nonatomic, retain) IBOutlet UITextView *sampleView;
@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, copy) NSString *fontFamilyName;
@property (nonatomic, retain) UIActionSheet *textsActionSheet;
@property (nonatomic, retain) UIActionSheet *otherActionsSheet;

- (IBAction)action:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)showComparativeTexts:(id)sender;
- (void)refresh;

@end
