//
//  MainController.h
//  FontKit
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontsController.h"
#import "FontsControllerDelegate.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "SizeControllerDelegate.h"

@class FontDetailController;
@class AboutController;
@class SizeController;

@interface MainController : FontsController <UIActionSheetDelegate,
                                             MFMailComposeViewControllerDelegate,
                                             FontsControllerDelegate,
                                             SizeControllerDelegate>
{
@private
    UIActionSheet *toolbarActionSheet;
    UINavigationController *controller;
    FontDetailController *detailController;
    AboutController *aboutBox;
    SizeController *_sizeController;
}

@property (nonatomic, retain) UINavigationController *controller;

@end
