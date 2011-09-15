//
//  FontsController.h
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontsControllerDelegate.h"

@interface FontsController : UITableViewController
{
@private
    NSArray *_familyNames;
    NSIndexPath *_selectedIndexPath;
    id<FontsControllerDelegate> _delegate;
<<<<<<< HEAD
    BOOL _showScrollingFonts;
    CGFloat _fontHeight;
}

@property (nonatomic, readonly) NSArray *familyNames;
@property (nonatomic, assign) id<FontsControllerDelegate> delegate;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
=======
}

@property (nonatomic, assign) IBOutlet id<FontsControllerDelegate> delegate;
>>>>>>> standard
@property (nonatomic, readonly) NSString *currentlySelectedFontName;
@property (nonatomic, readonly) NSString *currentlySelectedFontFamily;
@property (nonatomic) BOOL showScrollingFonts;
@property (nonatomic) CGFloat fontHeight;

@end
