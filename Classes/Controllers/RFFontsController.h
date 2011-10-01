//
//  RFFontsController.h
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFFontsControllerDelegate.h"

@interface RFFontsController : UITableViewController <UISearchDisplayDelegate,
                                                      UISearchBarDelegate>

@property (nonatomic, assign) IBOutlet id<RFFontsControllerDelegate> delegate;
@property (nonatomic, readonly) NSString *currentlySelectedFontName;
@property (nonatomic, readonly) NSString *currentlySelectedFontFamily;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, retain) UISearchDisplayController *searchController;
@property (nonatomic, retain) UISearchBar *searchBar;

@end
