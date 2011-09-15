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
<<<<<<< HEAD
    UIActionSheet *toolbarActionSheet;
    UINavigationController *controller;
    FontDetailController *detailController;
    AboutController *aboutBox;
    SizeController *_sizeController;
=======
    UIActionSheet *_toolbarActionSheet;
    UINavigationController *_controller;
    FontDetailController *_detailController;
    AboutController *_aboutBox;
>>>>>>> standard
}

@property (nonatomic, retain) UINavigationController *controller;

@end
