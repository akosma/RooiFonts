//
//  ComparisonPromptController.h
//  FontKit
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontsController.h"

@class ComparisonDetailController;

@interface ComparisonPromptController : FontsController <FontsControllerDelegate>
{
@private
    UINavigationController *controller;
    ComparisonDetailController *comparisonController;
}

@property (nonatomic, readonly) UINavigationController *controller;

@end
