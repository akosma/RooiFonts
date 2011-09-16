//
//  RFFontInfoControllerPad.h
//  RooiFonts
//
//  Created by Adrian on 9/16/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFFontInfoControllerPad : UIViewController <UITableViewDelegate, 
                                                       UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) UIFont *currentFont;

@end
