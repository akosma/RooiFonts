//
//  SizeController.h
//  FontKit
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SizeControllerDelegate.h"

@interface SizeController : UIViewController 
{
@private
    IBOutlet UISlider *slider;
    IBOutlet UILabel *sizeLabel;
    IBOutlet UISegmentedControl *specialSizes;
    NSObject<SizeControllerDelegate> *delegate;
}

@property (nonatomic, readonly) CGFloat size;
@property (nonatomic, assign) NSObject<SizeControllerDelegate> *delegate;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)selectedSpecialSize:(id)sender;

@end
