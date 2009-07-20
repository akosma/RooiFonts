//
//  SizeController.m
//  RooiFonts
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
