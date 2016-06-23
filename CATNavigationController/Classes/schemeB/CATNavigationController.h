//
//  CATNavigationController.h
//  Pods
//
//  Created by lben on 6/15/16.
//
//

#import <UIKit/UIKit.h>

@class CATNavigationController;

@protocol CATNavigationControllerDelegate <NSObject>
@end

@interface CATNavigationController : UINavigationController
@property (nonatomic, weak) id<CATNavigationControllerDelegate>delegate;
@end

@interface UINavigationController (CATNavigationController)
@property (nonatomic, assign, setter=at_setInteractiveMinMoveDistance:) CGFloat at_interactiveMinMoveDistance;
- (void)at_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)at_popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)at_popViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)at_popToRootViewControllerAnimated:(BOOL)animated;
@end

@interface UIViewController (CATNavigationController)
@property (nonatomic, assign, setter=at_setShowTabBar:) BOOL at_showTabBar;
@property (nonatomic, assign, setter=at_setHiddenNavigationBar:) BOOL at_hiddenNavigationBar;
@property (nonatomic, strong, setter=at_setNavigationBarBackgroundColor:) UIColor *at_navigationBarBackgroundColor;
@property (nonatomic, strong, setter=at_setNavigationBarBottomLineColor:) UIColor *at_navigationBarBottomLineColor;
@property (nonatomic, assign, setter=at_setAbleInteractivePop:) BOOL at_ableInteractivePop;
@end
