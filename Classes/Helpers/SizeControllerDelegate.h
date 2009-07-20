//
//  SizeControllerDelegate.h
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SizeController;

@protocol SizeControllerDelegate

@required
- (void)sizeController:(SizeController *)sizeController didChangeSize:(CGFloat)newSize;

@end
