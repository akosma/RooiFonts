//
//  FontsController.h
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright 2008 Adrian Kosmaczewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class FontDetailController;
@class AboutController;

@interface FontsController : UITableViewController <UIActionSheetDelegate,
                                                    MFMailComposeViewControllerDelegate>
{
@private
    UIActionSheet *toolbarActionSheet;
    UIActionSheet *accessoryActionSheet;
    NSArray *familyNames;
    UINavigationController *controller;
    FontDetailController *detailController;
    AboutController *aboutBox;
    NSIndexPath *selectedIndexPath;
}

@property (nonatomic, retain) UINavigationController *controller;

@end
