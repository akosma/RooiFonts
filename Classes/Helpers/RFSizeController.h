//
//  RFSizeController.h
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SizeControllerDelegate.h"

@interface RFSizeController : UIViewController 
{
@private
    UISlider *_slider;
    UILabel *_sizeLabel;
    id<SizeControllerDelegate> _delegate;
}

@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic, retain) IBOutlet UILabel *sizeLabel;
@property (nonatomic, assign) IBOutlet id<SizeControllerDelegate> delegate;

@property (nonatomic, readonly) CGFloat size;

- (IBAction)sliderValueChanged:(id)sender;

@end
