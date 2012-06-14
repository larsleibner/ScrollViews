//
//  ViewController.m
//  ScrollViews
//
//  Created by Lars Leibner on 31.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScrollViewController.h"

@implementation ScrollViewController

CGFloat const kToolBarHeightPortrait = 44;
CGFloat const kToolBarHeightLandscape = 32;
CGFloat const kSubViewHeightPortrait = 416;
CGFloat const kSubViewHeightLandscape = 268;

@synthesize scrollView = _scrollView;
@synthesize selectedChildViewController = _selectedChildViewController;
@synthesize subView = _subView;
@synthesize toolBar = _toolBar;
@synthesize upScaleSmallerViews = _upScaleSmallerViews;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.upScaleSmallerViews = NO;
        self.selectedChildViewController = 0;
    } else {
        [self release];
        self = nil;
    }
    return self;
    
}

- (void) dealloc 
{
    [_scrollView release];
    [_subView release];
    [_toolBar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    //[self.childViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    //        [(UIViewController *) obj didReceiveMemoryWarning];
    //}];    
}

- (void)addScrollableViewController:(UIViewController *)viewController {
    [self addChildViewController:viewController];
}

- (IBAction)selectView:(id)sender {
    [self.scrollView selectView];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {    
        [[NSBundle mainBundle] loadNibNamed:@"ScrollView_iPhone" owner:self options:nil];
    } else {
        [[NSBundle mainBundle] loadNibNamed:@"ScrollView_iPad" owner:self options:nil];            
    }
    
    self.scrollView.dataSource = self;
    
    [self.subView addSubview:self.scrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.subView = nil;
    self.toolBar = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.scrollView viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // For the iPhone/iPod not all orientations are allowed,
    // for the iPad every orientation is just fine
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

/*
 This method will adjust the user interface when a device rotation occurs.
 */
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration 
{
    CGRect toolBarFrame;
    CGRect subViewFrame;
    
    // Adjust the toolbar's height only for small screen sizes
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {    
        toolBarFrame = self.toolBar.frame;
        subViewFrame = self.scrollView.frame;
        
        // In landscape mode, the toolbar's height is reduced
        if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
            toolBarFrame.size.height = kToolBarHeightPortrait;
            subViewFrame.size.height = kSubViewHeightPortrait;
        } else {
            toolBarFrame.size.height = kToolBarHeightLandscape;
            subViewFrame.size.height = kSubViewHeightLandscape;
        }
        
        // Set the toolbar to the bottom of the super view
        toolBarFrame.origin.y = self.toolBar.superview.bounds.size.height - toolBarFrame.size.height;
        self.toolBar.frame = toolBarFrame;
        self.subView.frame = subViewFrame;
    }
}

@end
