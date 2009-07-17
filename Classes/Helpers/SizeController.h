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
    id<SizeControllerDelegate> delegate;
}

@property (nonatomic, readonly) CGFloat size;
@property (nonatomic, assign) id<SizeControllerDelegate> delegate;

- (IBAction)sliderValueChanged:(id)sender;

@end
