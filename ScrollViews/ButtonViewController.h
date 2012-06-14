//
//  ButtonViewController.h
//  ScrollViews
//
//  Created by Lars Leibner on 08.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonViewController : UIViewController {
@protected
    UIButton* _button;
}

@property (nonatomic, retain) IBOutlet UIButton* button;

- (IBAction)buttonClicked:(id)sender;

@end
