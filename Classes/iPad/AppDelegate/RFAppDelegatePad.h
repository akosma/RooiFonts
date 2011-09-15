//
//  RFAppDelegatePad.h
//  RooiFonts
//
//  Created by Adrian on 9/15/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFAppDelegatePad : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UISplitViewController *mainController;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
