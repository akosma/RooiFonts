//
//  RFFontsControllerDelegate.h
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RFFontsController;

@protocol RFFontsControllerDelegate <NSObject>

@required
- (void)fontsController:(RFFontsController *)controller rowSelectedAtIndexPath:(NSIndexPath *)indexPath;

@end
