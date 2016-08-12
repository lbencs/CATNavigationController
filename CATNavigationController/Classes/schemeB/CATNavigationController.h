//
//  CATNavigationController.h
//  Pods
//
//  Created by lben on 6/15/16.
//
//

#import <UIKit/UIKit.h>

@class CATNavigationController;

@interface CATNavigationController : UINavigationController
@end


@interface UINavigationController (CATNavigationController)

@property (nonatomic, strong, readonly) UIPercentDrivenInteractiveTransition *at_interactivePopTransition;
@property (nonatomic, assign, setter=at_setInteractiveMinMoveDistance:) CGFloat at_interactiveMinMoveDistance;
- (void)at_undoDelegate;
- (nullable NSArray<__kindof UIViewController *> *)popViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end


@interface UIViewController (CATNavigationController)

+ (void)at_customDisbaleAtPropertyForViewControllers:(NSArray *(^)())viewControllersBlock;

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

@property (nullable, nonatomic, weak) id<UINavigationBarDelegate>at_delegate;
@end
