//
//  ComparisonPromptController.h
//  FontKit
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontsController.h"

@interface ComparisonPromptController : FontsController <FontsControllerDelegate>
{
@private
    UINavigationController *controller;
}

@property (nonatomic, readonly) UINavigationController *controller;

@end
