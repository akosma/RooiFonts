//
//  FontsController.m
//  FontKit
//
//  Created by Adrian on 11/12/08.
//  Copyright 2008 Adrian Kosmaczewski. All rights reserved.
//

#import <MessageUI/MFMailComposeViewController.h>
#import "FontsController.h"
#import "FontDetailController.h"
#import "NSString+FirstLetters.h"
#import "UIFont+FontList.h"

@implementation FontsController

@synthesize controller;

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
    if (self = [super initWithStyle:UITableViewStylePlain])
    {
        familyNames = [[[UIFont familyNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] retain];
        controller = [[UINavigationController alloc] initWithRootViewController:self];
        controller.toolbarHidden = NO;
        detailController = [[FontDetailController alloc] init];
        self.tableView.rowHeight = 50;
        self.title = @"FontKit";
        
        UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [aboutButton addTarget:self
                        action:@selector(about:) 
              forControlEvents:UIControlEventTouchDown];
        UIBarButtonItem *aboutItem = [[UIBarButtonItem alloc] initWithCustomView:aboutButton];
        self.navigationItem.rightBarButtonItem = aboutItem;
        [aboutItem release];
        
        UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
                                                                                      target:self
                                                                                      action:@selector(action:)];
        
        NSArray *items = [[NSArray alloc] initWithObjects:actionButton, nil];
        self.toolbarItems = items;
        [actionButton release];
        [items release];
    }
    return self;
}

- (void)dealloc
{
    [controller release];
    [familyNames release];
    [detailController release];
    [super dealloc];
}

#pragma mark -
#pragma mark IBAction methods

- (void)about:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowAboutBox" 
                                                        object:self];
}

- (void)action:(id)sender
{
    toolbarActionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                     delegate:self 
                                            cancelButtonTitle:@"Cancel"
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:@"Copy", @"Send via e-mail", nil];
    [toolbarActionSheet showInView:controller.view];
    [toolbarActionSheet release];
}

#pragma mark -
#pragma mark UITableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return [familyNames count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
{
    return [familyNames valueForKey:@"firstLetters"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    NSArray *fontNames = [UIFont fontNamesForFamilyName:[familyNames objectAtIndex:section]];
    return [fontNames count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
    return [familyNames objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSArray *fontNames = [UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indexPath.section]];
    static NSString *identifier = @"iPhoneFontBrowser";
    NSString *font = [fontNames objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) 
    {
        CGRect rect = CGRectMake(0.0, 0.0, 320.0, 50.0);
        cell = [[[UITableViewCell alloc] initWithFrame:rect reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    cell.textLabel.font = [UIFont fontWithName:font size:18.0];
    cell.textLabel.text =  font;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSArray *fontNames = [UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indexPath.section]];
    NSString *identifier = [fontNames objectAtIndex:indexPath.row];
    detailController.fontName = identifier;
    detailController.title = identifier;
    [self.controller pushViewController:detailController animated:YES];
}

#pragma mark -
#pragma mark UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == toolbarActionSheet)
    {
        switch (buttonIndex)
        {
            case 0:
            {
                UIPasteboard *board = [UIPasteboard generalPasteboard];
                board.string = [UIFont fontList];
                break;
            }

            case 1:
            {
                MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
                picker.mailComposeDelegate = self;
                [picker setMessageBody:[UIFont fontList] isHTML:NO];
                [self presentModalViewController:picker animated:YES];
                [picker release];        
                break;
            }
                
            default:
                break;
        }
    }
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController*)composer didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [composer dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIViewController methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait) ||
            (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||   
            (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

@end
