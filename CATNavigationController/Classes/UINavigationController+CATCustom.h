//
//  UINavigationController+CATCustom.h
//  Pods
//
//  Created by lben on 6/15/16.
//
//

#import <UIKit/UIKit.h>

@interface UINavigationController (CATCustom)

- (void)at_fullScreenPushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)at_fullScreen;

- (void)at_hiddenBottomLine;
- (void)at_showBottomLine;
@end
