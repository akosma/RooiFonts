//
//  FontKitAppDelegate.h
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainController;

@interface FontKitAppDelegate : NSObject <UIApplicationDelegate> 
{
@private
    IBOutlet UIWindow *_window;
    MainController *_viewController;
    NSArray *_comparativeTexts;
}

@property (nonatomic, readonly) NSArray *comparativeTexts;

+ (FontKitAppDelegate *)sharedAppDelegate;

@end

