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
@class FontDetailController;

@interface SplitController : UIViewController <RFFontsControllerDelegate>
{
@private
    RFFontsController *_fontsController;
    FontDetailController *_fontDetailController;
}

@property (nonatomic, retain) IBOutlet RFFontsController *fontsController;
@property (nonatomic, retain) IBOutlet FontDetailController *fontDetailController;

@end
