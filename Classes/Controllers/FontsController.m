//
//  FontsController.m
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "FontsController.h"
#import "NSString+FirstLetters.h"
#import "RooiFontsAppDelegate.h"

@interface FontsController ()

@property (nonatomic, retain) NSArray *familyNames;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;

- (void)setup;

@end


@implementation FontsController

@synthesize familyNames = _familyNames;
@synthesize delegate = _delegate;
@synthesize selectedIndexPath = _selectedIndexPath;
@dynamic currentlySelectedFontName;
@dynamic currentlySelectedFontFamily;

#pragma mark -
#pragma mark Constructor and destructor

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

- (id)init
{
    if (self = [super initWithStyle:UITableViewStylePlain])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.tableView.rowHeight = 50;
    self.title = @"RooiFonts";
    self.familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (void)dealloc
{
    self.selectedIndexPath = nil;
    self.familyNames = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Property accessors

- (NSString *)currentlySelectedFontName
{
    NSString *fontName = nil;
    if (self.selectedIndexPath != nil)
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:self.currentlySelectedFontFamily];
        fontName = [fontNames objectAtIndex:self.selectedIndexPath.row];
    }
    return fontName;
}

- (NSString *)currentlySelectedFontFamily
{
    NSString *fontFamily = nil;
    if (self.selectedIndexPath != nil)
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
    if ([self.delegate respondsToSelector:@selector(fontsController:rowSelectedAtIndexPath:)])
    {
        [self.delegate fontsController:self rowSelectedAtIndexPath:indexPath];
    }
}

#pragma mark -
#pragma mark UIViewController methods

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    self.familyNames = nil;
}

@end
