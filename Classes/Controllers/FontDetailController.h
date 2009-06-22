//
//  FontDetailController.h
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SizeControllerDelegate.h"

@class SizeController;

@interface FontDetailController : UIViewController <UITextViewDelegate,
                                                    SizeControllerDelegate>
{
@private
    IBOutlet UITextView *sampleView;
    IBOutlet UITextView *alphabetTextView;
    IBOutlet UISegmentedControl *displayType;
    IBOutlet UIView *sizeView;
    SizeController *sizeController;
    UIBarButtonItem *button;
    NSString *fontName;
}

@property (nonatomic, copy) NSString *fontName;

- (IBAction)changedDisplayType:(id)sender;

@end
