//
//  FontTableCell.m
//  FontKit
//
//  Created by Adrian on 7/16/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontTableCell.h"
#import "FontKitAppDelegate.h"

@implementation FontTableCell

@dynamic showScrollingText;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier 
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) 
    {
        _showScrollingText = NO;
        self.accessoryType = UITableViewCellAccessoryNone;
        NSInteger height = self.contentView.frame.size.height;
        CGRect rect = CGRectMake(0.0, 0.0, 280.0, height);
        _scrollingView = [[UIScrollView alloc] initWithFrame:rect];
        _scrollingView.backgroundColor = [UIColor whiteColor];
        _scrollingView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)dealloc 
{
    [_scrollingView release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public properties

- (BOOL)showScrollingText
{
    return _showScrollingText;
}

- (void)setShowScrollingText:(BOOL)value
{
    _showScrollingText = value;
    if (_showScrollingText)
    {
        self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        NSInteger height = self.contentView.frame.size.height;
        CGRect rect = CGRectMake(0.0, 0.0, 280.0, height);
        _scrollingView.frame = rect;

        UIFont *currentFont = self.textLabel.font;
        NSArray *comparativeTexts = [FontKitAppDelegate sharedAppDelegate].comparativeTexts;
        NSString *comparisonText = [comparativeTexts objectAtIndex:5];
        CGSize comparisonSize = [comparisonText sizeWithFont:currentFont];

        UILabel *normalLabel = self.textLabel;
        CGFloat x = normalLabel.frame.origin.x;
        CGFloat y = normalLabel.frame.origin.y;
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, comparisonSize.width, normalLabel.frame.size.height)];
        tempLabel.text = comparisonText;
        tempLabel.font = currentFont;
        [_scrollingView addSubview:tempLabel];
        [tempLabel release];

        _scrollingView.contentSize = CGSizeMake(tempLabel.frame.size.width, _scrollingView.frame.size.height);
        [_scrollingView scrollRectToVisible:CGRectMake(0.0, 0.0, 1.0, 1.0) animated:NO];
        [self.contentView addSubview:_scrollingView];
    }
    else 
    {
        self.accessoryType = UITableViewCellAccessoryNone;
        [_scrollingView removeFromSuperview];
    }
}

@end
