//
//  RFMainController.h
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "FontsController.h"

@interface RFMainController : FontsController <UIActionSheetDelegate,
                                             MFMailComposeViewControllerDelegate,
                                             FontsControllerDelegate>

- (IBAction)about:(id)sender;
- (IBAction)action:(id)sender;

@end
