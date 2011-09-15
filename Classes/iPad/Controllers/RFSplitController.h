//
//  RFSplitController.h
//  RooiFonts
//
//  Created by Adrian on 9/15/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFFontsControllerDelegate.h"

@class RFFontDetailControllerPad;
@class RFFontsController;

@interface RFSplitController : UISplitViewController <UISplitViewControllerDelegate, 
                                                      RFFontsControllerDelegate>

@property (nonatomic, retain) IBOutlet RFFontDetailControllerPad *detailController;
@property (nonatomic, retain) IBOutlet RFFontsController *fontsController;

@end
