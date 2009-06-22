//
//  UIFont+FontList.m
//  FontBrowser
//
//  Created by Adrian on 6/21/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "UIFont+FontList.h"

@implementation UIFont (FontList)

+ (NSString *)fontList
{
    NSMutableString *fonts = [[NSMutableString alloc] init];
    NSArray *familyNames = [[[UIFont familyNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] retain];
    for (NSString *familyName in familyNames)
    {
        [fonts appendFormat:@"Family %@: \n", familyName];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for (NSString *fontName in fontNames)
        {
            [fonts appendFormat:@"%@ \n", fontName];
        }
        [fonts appendString:@"\n"];
    }
    [familyNames release];
    return [fonts autorelease];
}

@end
