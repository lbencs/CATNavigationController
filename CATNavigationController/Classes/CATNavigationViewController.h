//
//  CATNavigationViewController.h
//  Pods
//
//  Created by lben on 6/15/16.
//
//

#import <UIKit/UIKit.h>

@interface CATNavigationViewController : UINavigationController

- (void)at_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)at_popViewControllerAnimated:(BOOL)animated;







@end
