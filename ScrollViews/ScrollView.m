//
//  ScrollView.m
//  ScrollViews
//
//  Created by Lars Leibner on 05.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScrollView.h"
#import <QuartzCore/QuartzCore.h>

@interface ScrollView()
- (CGRect)determineFrameForView:(UIView *)view
                     withOffset:(NSUInteger)offset;
@end

@implementation ScrollView

@synthesize backgroundView = _backgroundView;
@synthesize dataSource = _dataSource;
@synthesize gradientLayer = _gradientLayer;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    //Create the gradient layer for the background
    //and set it's size to the background view's size
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.backgroundView.frame;
    
    //Create the gradient colors
    UIColor *topColor = [UIColor colorWithRed:0.57 green:0.63 blue:0.68 alpha:1.0]; //light blue-gray
	UIColor *bottomColor = [UIColor colorWithRed:0.31 green:0.41 blue:0.48 alpha:1.0]; //dark blue-gray
	self.gradientLayer.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    
    //Add the layer to the background view
    [self.backgroundView.layer addSublayer:self.gradientLayer];
    
    //Set the initial scroll view's content size - equal to the scroll view's size
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
}

- (void)dealloc {
    [_scrollView release];
    [_pageControl release];
}   

- (void) viewWillAppear:(BOOL)animated {
    
    CGRect frame;
    CGSize contentSize;
    int offset = 0;
    
    for (UIViewController* viewController in self.dataSource.childViewControllers) {
        
        UIView* view = viewController.view;
        
        frame = [self determineFrameForView:view withOffset:offset];
        offset += frame.size.width + (self.scrollView.bounds.size.width - frame.size.width);
        
        view.transform = CGAffineTransformMakeScale(frame.size.width / view.frame.size.width, frame.size.height / view.frame.size.height);
        
        [view removeFromSuperview];
        view.frame = frame;
        view.userInteractionEnabled = NO;
        [self.scrollView addSubview:view];
    }
    
    contentSize = self.scrollView.contentSize;
    contentSize.width = offset;
    self.scrollView.contentSize = contentSize;
}

- (CGRect) determineFrameForView:(UIView *)view 
                      withOffset:(NSUInteger)offset {
    
    CGFloat factor;
    CGRect frame = view.frame;
    
    factor = self.scrollView.bounds.size.width / view.bounds.size.width * 0.8;
    
    frame.size.width *= factor;
    frame.size.height *= factor;
    frame.origin.y = (self.scrollView.bounds.size.height - frame.size.height) / 2;
    frame.origin.x = (self.scrollView.bounds.size.width - frame.size.width) / 2;
    frame.origin.x += offset;
    
    return frame;
}

- (void)selectView {
    
}

- (void) layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    self.gradientLayer.frame = self.backgroundView.frame;
}

@end
