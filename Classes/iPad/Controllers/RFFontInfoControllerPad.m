//
//  RFFontInfoControllerPad.m
//  RooiFonts
//
//  Created by Adrian on 9/16/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import "RFFontInfoControllerPad.h"

@interface RFFontInfoControllerPad ()

@property (nonatomic, retain) NSMutableArray *fontData;
@property (nonatomic, retain) NSArray *keys;

- (void)updateFontData;

@end


@implementation RFFontInfoControllerPad

@synthesize tableView = _tableView;
@synthesize currentFont = _currentFont;
@synthesize fontData = _fontData;
@synthesize keys = _keys;

- (void)dealloc
{
    [_keys release];
    [_fontData release];
    [_currentFont release];
    [_tableView release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.keys = [NSArray arrayWithObjects:@"pointSize", @"ascender", @"descender", 
                 @"capHeight", @"xHeight", @"lineHeight", nil];
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 320.0);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateFontData];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fontData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.currentFont.fontName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                       reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *key = [self.keys objectAtIndex:indexPath.row];
    NSDictionary *dict = [self.fontData objectAtIndex:indexPath.row];
    cell.textLabel.text = key;
    cell.detailTextLabel.text = [[dict objectForKey:key] stringValue];
    
    return cell;
}

#pragma mark - Private methods

- (void)updateFontData
{
    self.fontData = [NSMutableArray arrayWithCapacity:[self.keys count]];
    for (NSString *key in self.keys)
    {
        NSNumber *value = [self.currentFont valueForKey:key];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:value, key, nil];
        [self.fontData addObject:dict];
    }
}

@end
