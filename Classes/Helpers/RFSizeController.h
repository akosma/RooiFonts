//
//  RFSizeController.h
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFSizeControllerDelegate.h"

@interface RFSizeController : UIViewController 

@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic, retain) IBOutlet UILabel *sizeLabel;
@property (nonatomic, assign) IBOutlet id<RFSizeControllerDelegate> delegate;

@property (nonatomic, readonly) CGFloat size;

- (IBAction)sliderValueChanged:(id)sender;

@end
