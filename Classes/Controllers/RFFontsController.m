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
@property (nonatomic, retain) NSMutableArray *filteredFamilyNames;
@property (nonatomic, getter = isSearching) BOOL searching;

- (void)filterContentForSearchText:(NSString *)searchText;

@end


@implementation RFFontsController

@synthesize familyNames = _familyNames;
@synthesize delegate = _delegate;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize searchController = _searchController;
@synthesize filteredFamilyNames = _filteredFamilyNames;
@synthesize searchBar = _searchBar;
@synthesize searching = _searching;
@dynamic currentlySelectedFontName;
@dynamic currentlySelectedFontFamily;

- (void)dealloc
{
    [_selectedIndexPath release];
    [_familyNames release];
    [_searchController release];
    [_filteredFamilyNames release];
    [_searchBar release];
    [super dealloc];
}

#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"RooiFonts";
    self.familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)] autorelease];
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    self.searchController = [[[UISearchDisplayController alloc] initWithSearchBar:self.searchBar 
                                                               contentsController:self] autorelease];
    self.searchController.delegate = self;
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    
    self.filteredFamilyNames = [NSMutableArray arrayWithCapacity:[self.familyNames count]];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    self.familyNames = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) || UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
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
        if (self.isSearching)
        {
            fontFamily = [self.filteredFamilyNames objectAtIndex:self.selectedIndexPath.section];
        }
        else
        {
            fontFamily = [self.familyNames objectAtIndex:self.selectedIndexPath.section];
        }
    }
    return fontFamily;
}

#pragma mark - UITableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredFamilyNames count];
    }
    return [self.familyNames count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
{
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return nil;
    }
    return [self.familyNames valueForKey:@"firstLetters"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    NSString *name = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        name = [self.filteredFamilyNames objectAtIndex:section];
    }
    else
    {
        name = [self.familyNames objectAtIndex:section];
    }
    NSArray *fontNames = [UIFont fontNamesForFamilyName:name];
    return [fontNames count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredFamilyNames objectAtIndex:section];
    }
    return [self.familyNames objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        name = [self.filteredFamilyNames objectAtIndex:indexPath.section];
    }
    else
    {
        name = [self.familyNames objectAtIndex:indexPath.section];
    }
    NSArray *fontNames = [UIFont fontNamesForFamilyName:name];
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
    NSString *name = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        name = [self.filteredFamilyNames objectAtIndex:indexPath.section];
    }
    else
    {
        name = [self.familyNames objectAtIndex:indexPath.section];
    }
    NSArray *fontNames = [UIFont fontNamesForFamilyName:name];
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
    cell.textLabel.text = font;
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

#pragma mark - UISearchDisplayDelegate methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    return YES;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    self.searching = YES;
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    self.searching = NO;
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.searching = NO;
}

#pragma mark - Private methods

- (void)filterContentForSearchText:(NSString *)searchText
{
	[self.filteredFamilyNames removeAllObjects];
	
	for (NSString *family in self.familyNames)
	{
        NSRange result = [family rangeOfString:searchText
                                       options:NSCaseInsensitiveSearch];
        if (result.location != NSNotFound)
        {
            [self.filteredFamilyNames addObject:family];
            continue;
        }
        
        // Look in the individual fonts now
        NSArray *fontNames = [UIFont fontNamesForFamilyName:family];
        for (NSString *font in fontNames)
        {
            NSRange result = [font rangeOfString:searchText
                                         options:NSCaseInsensitiveSearch];
            if (result.location != NSNotFound)
            {
                [self.filteredFamilyNames addObject:family];
                break;
            }
        }
	}
}

@end
