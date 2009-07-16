//
//  FontTableCell.h
//  FontKit
//
//  Created by Adrian on 7/16/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontTableCell : UITableViewCell 
{
@private
    BOOL _showScrollingText;
    UIScrollView *_scrollingView;
}

@property (nonatomic) BOOL showScrollingText;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
