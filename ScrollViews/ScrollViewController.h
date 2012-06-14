//
//  ViewController.h
//  ScrollViews
//
//  Created by Lars Leibner on 31.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollView.h"

@interface ScrollViewController : UIViewController {
    
@protected 
    
    //Reference to the scroll view where the child view controller's views will
    //be presented
    ScrollView* _scrollView; 
    
    //Reference to the subview 
    //At runtime this will either point to the scroll view or to the
    //view of the selected child view controller (the selected content controller)
    UIView* _subView;
    
    //the view controller's toolbar
    UIToolbar* _toolBar;
    
    //Indicates, whether views, that are smaller than the scroll view, should be upscaled
    BOOL _upScaleSmallerViews;
    
    NSUInteger _selectedChildViewController;
}

@property (nonatomic, retain) IBOutlet ScrollView* scrollView;
@property (nonatomic, assign) NSUInteger selectedChildViewController;
@property (nonatomic, retain) IBOutlet UIView* subView;
@property (nonatomic, retain) IBOutlet UIToolbar* toolBar;
@property (nonatomic, assign) BOOL upScaleSmallerViews;

- (void) addScrollableViewController:(UIViewController *) viewController;
- (IBAction)selectView:(id)sender;

@end
