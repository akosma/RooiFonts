//
//  NSString+FirstLetters.m
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "NSString+FirstLetters.h"

@implementation NSString (FirstLetter)

- (NSString *)firstLetters
{
    return [self substringToIndex:2];
}

@end
