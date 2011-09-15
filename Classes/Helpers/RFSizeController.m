//
//  RFSizeController.m
//  RooiFonts
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "RFSizeController.h"

@interface RFSizeController ()

@end


@implementation RFSizeController

@synthesize delegate = _delegate;
@synthesize slider = _slider;
@synthesize sizeLabel = _sizeLabel;
@dynamic size;

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
    return self.slider.value;
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)sliderValueChanged:(id)sender
{
    self.sizeLabel.text = [NSString stringWithFormat:@"%1.0f pt", self.slider.value];
    if ([self.delegate respondsToSelector:@selector(sizeController:didChangeSize:)])
    {
        [self.delegate sizeController:self didChangeSize:self.slider.value];
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
    return YES;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

@end
