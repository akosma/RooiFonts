//
//  FontsController.m
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontsController.h"
#import "NSString+FirstLetters.h"
#import "FontTableCell.h"

@implementation FontsController

@dynamic familyNames;
@synthesize delegate = _delegate;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize showScrollingFonts = _showScrollingFonts;
@synthesize fontHeight = _fontHeight;
@dynamic currentlySelectedFontName;
@dynamic currentlySelectedFontFamily;

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
    if (self = [super initWithStyle:UITableViewStylePlain])
    {
        _fontHeight = 18.0;
        _showScrollingFonts = NO;
        self.title = @"FontKit";
    }
    return self;
}

- (void)dealloc
{
    [_selectedIndexPath release];
    [_familyNames release];
    [super dealloc];
}

#pragma mark -
#pragma mark Property accessors

- (NSArray *)_familyNames
{
    if (_familyNames == nil)
    {
        _familyNames = [[[UIFont familyNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] retain];
    }
    return _familyNames;
}

- (NSString *)currentlySelectedFontName
{
    NSString *fontName = nil;
    if (_selectedIndexPath != nil)
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:self.currentlySelectedFontFamily];
        fontName = [fontNames objectAtIndex:self.selectedIndexPath.row];
    }
    return fontName;
}

- (NSString *)currentlySelectedFontFamily
{
    NSString *fontFamily = nil;
    if (_selectedIndexPath != nil)
    {
        fontFamily = [self._familyNames objectAtIndex:self.selectedIndexPath.section];
    }
    return fontFamily;
}

#pragma mark -
#pragma mark UITableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return [self._familyNames count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
{
    if (_showScrollingFonts)
    {
        return nil;
    }
    return [self._familyNames valueForKey:@"firstLetters"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    NSArray *fontNames = [UIFont fontNamesForFamilyName:[self._familyNames objectAtIndex:section]];
    return [fontNames count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _fontHeight + 40.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
    return [self._familyNames objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSArray *fontNames = [UIFont fontNamesForFamilyName:[self._familyNames objectAtIndex:indexPath.section]];
    static NSString *identifier = @"iPhoneFontBrowser";
    NSString *font = [fontNames objectAtIndex:indexPath.row];
    FontTableCell *cell = (FontTableCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) 
    {
        cell = [[[FontTableCell alloc] initWithReuseIdentifier:identifier] autorelease];
    }
    cell.textLabel.text = font;
    cell.textLabel.font = [UIFont fontWithName:font size:_fontHeight];
    cell.showScrollingText = _showScrollingFonts;
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    self.selectedIndexPath = indexPath;
    if ([_delegate respondsToSelector:@selector(fontsController:rowSelectedAtIndexPath:)])
    {
        [_delegate fontsController:self rowSelectedAtIndexPath:indexPath];
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
    [_familyNames release];
    _familyNames = nil;
    [super didReceiveMemoryWarning];
}

@end
