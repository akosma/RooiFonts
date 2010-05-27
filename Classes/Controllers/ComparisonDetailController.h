//
//  ComparisonDetailController.h
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SizeControllerDelegate.h"

@class SizeController;

@interface ComparisonDetailController : UIViewController <SizeControllerDelegate>
{
@private
    IBOutlet UIView *_sizeView;
    IBOutlet UITextView *_topView;
    IBOutlet UITextView *_bottomView;
    SizeController *_sizeController;
    
    NSString *_topFontName;
    NSString *_bottomFontName;
}

@property (nonatomic, retain) IBOutlet UIView *sizeView;
@property (nonatomic, retain) IBOutlet UITextView *topView;
@property (nonatomic, retain) IBOutlet UITextView *bottomView;
@property (nonatomic, copy) NSString *topFontName;
@property (nonatomic, copy) NSString *bottomFontName;

@end
