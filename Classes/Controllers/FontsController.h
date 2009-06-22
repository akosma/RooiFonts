//
//  FontsController.h
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontsControllerDelegate.h"

@interface FontsController : UITableViewController
{
@private
    NSArray *familyNames;
    NSIndexPath *selectedIndexPath;
    NSObject<FontsControllerDelegate> *delegate;
    UITableViewCellAccessoryType accessoryType;
}

@property (nonatomic, readonly) NSArray *familyNames;
@property (nonatomic, assign) NSObject<FontsControllerDelegate> *delegate;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, readonly) NSString *currentlySelectedFontName;
@property (nonatomic, readonly) NSString *currentlySelectedFontFamily;
@property (nonatomic) UITableViewCellAccessoryType accessoryType;

@end
