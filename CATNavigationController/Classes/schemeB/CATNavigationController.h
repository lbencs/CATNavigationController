//
//  CATNavigationController.h
//  Pods
//
//  Created by lben on 6/15/16.
//
//

#import <UIKit/UIKit.h>

@class CATNavigationController;

@protocol CATNavigationControllerDelegate <UINavigationControllerDelegate>
@end


@interface CATNavigationController : UINavigationController

@end


@interface UINavigationController (CATNavigationController)

@property (nullable, nonatomic, weak) id<CATNavigationControllerDelegate> at_delegate;
@property (nonatomic, assign, setter=at_setInteractiveMinMoveDistance:) CGFloat at_interactiveMinMoveDistance;

- (void)at_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)at_popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)at_popViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)at_popToRootViewControllerAnimated:(BOOL)animated;
@end


@interface UIViewController (CATNavigationController)

//default is YES, when push from viewcontroller with UITabBarController,yes: show UITabBar, no: hidden UITabBar.
@property (nonatomic, assign, setter=at_setShowTabBar:) BOOL at_showTabBar;

//default is NO, when is YES, show the NavigationBar in the next page.
@property (nonatomic, assign, setter=at_setHiddenNavigationBar:) BOOL at_hiddenNavigationBar;
@property (nullable, nonatomic, strong, setter=at_setNavigationBarBackgroundColor:) UIColor *at_navigationBarBackgroundColor;
@property (nullable, nonatomic, strong, setter=at_setNavigationBarBottomLineColor:) UIColor *at_navigationBarBottomLineColor;
//default is NO
@property (nonatomic, assign, setter=at_setAbleInteractivePop:) BOOL at_disableInteractivePop;
//default is UIStatusBarStyleDefault
@property (nonatomic, assign, setter=at_setStatusBarStyle:) UIStatusBarStyle at_statusBarStyle;

@property (nonatomic, assign, setter=at_setTranslucent:) BOOL at_translucent;
@end
