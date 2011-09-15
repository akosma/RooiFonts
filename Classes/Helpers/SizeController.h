//
//  SizeController.h
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SizeControllerDelegate.h"

@interface SizeController : UIViewController 
{
@private
<<<<<<< HEAD
    IBOutlet UISlider *slider;
    IBOutlet UILabel *sizeLabel;
    id<SizeControllerDelegate> delegate;
=======
    UISlider *_slider;
    UILabel *_sizeLabel;
    id<SizeControllerDelegate> _delegate;
>>>>>>> standard
}

@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic, retain) IBOutlet UILabel *sizeLabel;
@property (nonatomic, assign) IBOutlet id<SizeControllerDelegate> delegate;

@property (nonatomic, readonly) CGFloat size;
<<<<<<< HEAD
@property (nonatomic, assign) id<SizeControllerDelegate> delegate;
=======
>>>>>>> standard

- (IBAction)sliderValueChanged:(id)sender;

@end
