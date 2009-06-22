//
//  FontsController.m
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontsController.h"
#import "NSString+FirstLetters.h"

@implementation FontsController

@dynamic familyNames;
@synthesize delegate;
@synthesize selectedIndexPath;
@dynamic currentlySelectedFontName;
@dynamic currentlySelectedFontFamily;

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
    if (self = [super initWithStyle:UITableViewStylePlain])
    {
        self.tableView.rowHeight = 50;
        self.title = @"FontKit";
    }
    return self;
}

- (void)dealloc
{
    [selectedIndexPath release];
    [familyNames release];
    [super dealloc];
}

#pragma mark -
#pragma mark Property accessors

- (NSArray *)familyNames
{
    if (familyNames == nil)
    {
        familyNames = [[[UIFont familyNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] retain];
    }
    return familyNames;
}

- (NSString *)currentlySelectedFontName
{
    NSString *fontName = nil;
    if (selectedIndexPath != nil)
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:self.currentlySelectedFontFamily];
        fontName = [fontNames objectAtIndex:self.selectedIndexPath.row];
    }
    return fontName;
}

- (NSString *)currentlySelectedFontFamily
{
    NSString *fontFamily = nil;
    if (selectedIndexPath != nil)
    {
        fontFamily = [self.familyNames objectAtIndex:self.selectedIndexPath.section];
    }
    return fontFamily;
}

#pragma mark -
#pragma mark UITableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return [self.familyNames count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
{
    return [self.familyNames valueForKey:@"firstLetters"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    NSArray *fontNames = [UIFont fontNamesForFamilyName:[self.familyNames objectAtIndex:section]];
    return [fontNames count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
    return [self.familyNames objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSArray *fontNames = [UIFont fontNamesForFamilyName:[self.familyNames objectAtIndex:indexPath.section]];
    static NSString *identifier = @"iPhoneFontBrowser";
    NSString *font = [fontNames objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) 
    {
        CGRect rect = CGRectMake(0.0, 0.0, 320.0, 50.0);
        cell = [[[UITableViewCell alloc] initWithFrame:rect reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.font = [UIFont fontWithName:font size:18.0];
    cell.textLabel.text =  font;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    self.selectedIndexPath = indexPath;
    if ([delegate respondsToSelector:@selector(fontsController:rowSelectedAtIndexPath:)])
    {
        [delegate fontsController:self rowSelectedAtIndexPath:indexPath];
    }
}

#pragma mark -
#pragma mark UIViewController methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning 
{
    [familyNames release];
    familyNames = nil;
    [super didReceiveMemoryWarning];
}

@end
