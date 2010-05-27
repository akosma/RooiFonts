//
//  SplitController.h
//  RooiFonts
//
//  Created by Adrian on 5/27/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontsControllerDelegate.h"

@class FontsController;
@class FontDetailController;

@interface SplitController : UIViewController <FontsControllerDelegate>
{
@private
    FontsController *_fontsController;
    FontDetailController *_fontDetailController;
}

@property (nonatomic, retain) IBOutlet FontsController *fontsController;
@property (nonatomic, retain) IBOutlet FontDetailController *fontDetailController;

@end
