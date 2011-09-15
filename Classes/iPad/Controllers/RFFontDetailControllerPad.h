//
//  RFFontDetailControllerPad.h
//  RooiFonts
//
//  Created by Adrian on 9/15/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import "RFFontDetailController.h"

@interface RFFontDetailControllerPad : RFFontDetailController <UISplitViewControllerDelegate>

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *actionButtonItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *textButtonItem;

@end
