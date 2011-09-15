//
//  ComparisonPromptController.h
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "RFFontsController.h"

@class ComparisonDetailController;

@interface ComparisonPromptController : RFFontsController <RFFontsControllerDelegate>
{
@private
    ComparisonDetailController *_comparisonController;
}

@end
