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
    IBOutlet UIView *sizeView;
    IBOutlet UITextView *topView;
    IBOutlet UITextView *bottomView;
    SizeController *sizeController;
    
    NSString *topFontName;
    NSString *bottomFontName;
}

@property (nonatomic, copy) NSString *topFontName;
@property (nonatomic, copy) NSString *bottomFontName;

@end
