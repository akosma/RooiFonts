//
//  SizeControllerDelegate.h
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RFSizeController;

@protocol SizeControllerDelegate <NSObject>

@required
- (void)sizeController:(RFSizeController *)sizeController didChangeSize:(CGFloat)newSize;

@end
