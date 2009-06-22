//
//  SizeController.m
//  FontKit
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "SizeController.h"

@implementation SizeController

@dynamic size;
@synthesize delegate;

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
    if (self = [super initWithNibName:@"Size" bundle:nil]) 
    {
    }
    return self;
}

- (void)dealloc 
{
    [super dealloc];
}

#pragma mark -
#pragma mark Property accessors

- (CGFloat)size
{
    return slider.value;
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)sliderValueChanged:(id)sender
{
    sizeLabel.text = [NSString stringWithFormat:@"%1.0f pt", slider.value];
    specialSizes.selectedSegmentIndex = -1;
    
    if ([sizeLabel.text floatValue] == [UIFont smallSystemFontSize])
    {
        specialSizes.selectedSegmentIndex = 0;
    }
    else if ([sizeLabel.text floatValue] == [UIFont systemFontSize])
    {
        specialSizes.selectedSegmentIndex = 1;
    }
    else if ([sizeLabel.text floatValue] == [UIFont labelFontSize])
    {
        specialSizes.selectedSegmentIndex = 2;
    }
    else if ([sizeLabel.text floatValue] == [UIFont buttonFontSize])
    {
        specialSizes.selectedSegmentIndex = 3;
    }
    
    if ([delegate respondsToSelector:@selector(sizeController:didChangeSize:)])
    {
        [delegate sizeController:self didChangeSize:slider.value];
    }
}

- (IBAction)selectedSpecialSize:(id)sender
{
    CGFloat value = -1.0;
    switch (specialSizes.selectedSegmentIndex) 
    {
        case 0:
        {
            value = [UIFont smallSystemFontSize];
            break;
        }
            
        case 1:
        {
            value = [UIFont systemFontSize];
            break;
        }
            
        case 2:
        {
            value = [UIFont labelFontSize];
            break;
        }
            
        case 3:
        {
            value = [UIFont buttonFontSize];
            break;
        }
            
        default:
            break;
    }
    if (value != -1.0)
    {
        slider.value = value;
        sizeLabel.text = [NSString stringWithFormat:@"%1.0f pt", slider.value];
    }
    if ([delegate respondsToSelector:@selector(sizeController:didChangeSize:)])
    {
        [delegate sizeController:self didChangeSize:slider.value];
    }
}

#pragma mark -
#pragma mark UIViewController methods

- (void)viewDidLoad 
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

@end
