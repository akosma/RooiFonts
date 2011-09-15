//
//  RFFontsControllerPad.m
//  RooiFonts
//
//  Created by Adrian on 9/15/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import "RFFontsControllerPad.h"


@implementation RFFontsControllerPad

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.selectedIndexPath = indexPath;
    [self.tableView selectRowAtIndexPath:indexPath
                                animated:NO 
                          scrollPosition:UITableViewScrollPositionNone];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
