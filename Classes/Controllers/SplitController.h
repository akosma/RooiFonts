//
//  SplitController.h
//  RooiFonts
//
//  Created by Adrian on 5/27/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFFontsControllerDelegate.h"

@class RFFontsController;
@class RFFontDetailController;

@interface SplitController : UIViewController <RFFontsControllerDelegate>
{
@private
    RFFontsController *_fontsController;
    RFFontDetailController *_fontDetailController;
}

@property (nonatomic, retain) IBOutlet RFFontsController *fontsController;
@property (nonatomic, retain) IBOutlet RFFontDetailController *fontDetailController;

@end
