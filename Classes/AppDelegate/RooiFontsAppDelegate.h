//
//  RooiFontsAppDelegate.h
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainController;

@interface RooiFontsAppDelegate : NSObject <UIApplicationDelegate> 
{
@private
    UIWindow *_window;
    MainController *_viewController;
    id _splitViewController;
}

@property (nonatomic, retain) IBOutlet id splitViewController;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, readonly) BOOL userInterfaceIdiomPad;

+ (RooiFontsAppDelegate *)sharedAppDelegate;

@end
