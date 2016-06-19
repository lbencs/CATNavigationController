//
//  UIViewController+CATNavigationController.h
//  Pods
//
//  Created by lben on 6/17/16.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (CATNavigationController)

@property (nonatomic, assign, setter=at_setHiddenNavigationBar:) BOOL at_hiddenNavigationBar;
@property (nonatomic, assign, setter=at_setShowTabBar:) BOOL at_showTabBar;

@end
