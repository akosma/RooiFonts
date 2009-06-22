//
//  FontKitAppDelegate.h
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright Adrian Kosmaczewski 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FontsController;

@interface FontKitAppDelegate : NSObject <UIApplicationDelegate> 
{
@private
    IBOutlet UIWindow *window;
    FontsController *viewController;
}

@end

