//
//  ScrollView.h
//  ScrollViews
//
//  Created by Lars Leibner on 05.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ScrollView : UIView {
@protected
    CAGradientLayer* _gradientLayer;
    UIScrollView* _scrollView;
    UIPageControl* _pageControl;
    UIViewController* _dataSource;
    UIView* _backgroundView;
}

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;
@property (nonatomic, assign) UIViewController* dataSource;
@property (nonatomic, retain) IBOutlet UIView* backgroundView;
@property (nonatomic, retain) CAGradientLayer* gradientLayer;

- (void) viewWillAppear:(BOOL) animated;
- (void) selectView;

@end
