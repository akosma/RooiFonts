//
//  RFFontsController.m
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "RFFontsController.h"
#import "NSString+RooiFonts.h"

@interface RFFontsController ()

@property (nonatomic, retain) NSArray *familyNames;

@end


@implementation RFFontsController

@synthesize familyNames = _familyNames;
@synthesize delegate = _delegate;
@synthesize selectedIndexPath = _selectedIndexPath;
@dynamic currentlySelectedFontName;
@dynamic currentlySelectedFontFamily;

- (void)dealloc
{
    self.selectedIndexPath = nil;
    self.familyNames = nil;
    [super dealloc];
}

#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"RooiFonts";
    self.familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    self.familyNames = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

#pragma mark - Property accessors

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

#pragma mark - UITableView delegate methods

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *fontNames = [UIFont fontNamesForFamilyName:[self.familyNames objectAtIndex:indexPath.section]];
    NSString *fontName = [fontNames objectAtIndex:indexPath.row];
    UIFont *font = [UIFont fontWithName:fontName size:18.0];
    CGSize size = [fontName sizeWithFont:font];
    CGFloat height = size.height + 20.0;
    if (height < 44.0)
    {
        height = 44.0;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSArray *fontNames = [UIFont fontNamesForFamilyName:[self.familyNames objectAtIndex:indexPath.section]];
    NSString *font = [fontNames objectAtIndex:indexPath.row];

    static NSString *identifier = @"iPhoneFontBrowserCell";
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

@end
