//
//  MainController.h
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontsController.h"
#import "FontsControllerDelegate.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class FontDetailController;
@class AboutController;

@interface MainController : FontsController <UIActionSheetDelegate,
                                             MFMailComposeViewControllerDelegate,
                                             FontsControllerDelegate>

- (IBAction)about:(id)sender;
- (IBAction)action:(id)sender;

@end
