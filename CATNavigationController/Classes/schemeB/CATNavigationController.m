//
//  CATNavigationController.m
//  Pods
//
//  Created by lben on 6/15/16.
//
//

#import "CATNavigationController.h"
#import "CATCoreNavigationController.h"
#import "CATWrapViewController.h"
#import "CATPopTransitionAnimation.h"
#import "CATPushTransitionAnimation.h"
#import "CATProvider.h"
#import <objc/runtime.h>
#import "UINavigationBar+CATCustom.h"

#define CATAssociatedProperty(_get, _set, _type)                         \
    -(instancetype)_get { return objc_getAssociatedObject(self, _cmd); } \
    -(void)_set(_type) value { objc_setAssociatedObject(self, @selector(_get), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
#define CATAssociatedBoolProperty(_get, _set)                                \
    -(BOOL)_get { return [objc_getAssociatedObject(self, _cmd) boolValue]; } \
    -(void)_set(BOOL) value { objc_setAssociatedObject(self, @selector(_get), @(value), OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
#define CATAssociatedIntProperty(_get, _set)                                         \
    -(NSInteger)_get { return [objc_getAssociatedObject(self, _cmd) integerValue]; } \
    -(void)_set(NSInteger) value { objc_setAssociatedObject(self, @selector(_get), @(value), OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
@implementation CATNavigationController
@end


@interface CATNavigationControllerDelegate : NSObject <UINavigationControllerDelegate>
@property (nonatomic, weak) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@end


@implementation CATNavigationControllerDelegate
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
}
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return [[CATPopTransitionAnimation alloc] initWithCompletion:^{
            if ([[CATPageManager shareManager] animationStatus] == CATNavigationPopAnimationDragFinished ||
                [[CATPageManager shareManager] animationStatus] == CATNavigationPopAnimationPop) {
                [[CATPageManager shareManager] pop];
            }
            [CATPageManager shareManager].animationStatus = CATNavigationPopAnimationPop;
        }];
    } else if (operation == UINavigationControllerOperationPush) {
        return [[CATPushTransitionAnimation alloc] init];
    } else if (operation == UINavigationControllerOperationNone) {
//        NSLog(@"none");
    }

    return nil;
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if ([animationController isKindOfClass:[CATPopTransitionAnimation class]]) {
        return self.interactivePopTransition;
    } else if ([animationController isKindOfClass:[CATPushTransitionAnimation class]]) {
        return nil;
    }
    return nil;
}
- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    return UIInterfaceOrientationMaskAll;
}
- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController
{
    return UIInterfaceOrientationMaskAll;
}
@end


@interface UINavigationController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong, readwrite, setter=at_setInteractivePopTransition:) UIPercentDrivenInteractiveTransition *at_interactivePopTransition;

@property (nonatomic, weak, setter=_setCustomPopGestureRecognizer:) UIPanGestureRecognizer *_customPopGestureRecognizer;
@property (nonatomic, strong, setter=_setDelegate:) CATNavigationControllerDelegate *_delegate;
@property (nonatomic, assign, setter=_setAbleInteractivePop:) BOOL _ableInteractivePop;
@end


@implementation UINavigationController (CATNavigationController)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CATSwizzeMethod([self class],
                        @selector(viewDidLoad),
                        @selector(at_viewDidLoad));

        CATSwizzeMethod([self class],
                        @selector(popViewControllerAnimated:),
                        @selector(at_popViewControllerAnimated:));

        CATSwizzeMethod([self class],
                        @selector(popToViewController:animated:),
                        @selector(at_popToViewController:animated:));

        CATSwizzeMethod([self class],
                        @selector(popToRootViewControllerAnimated:),
                        @selector(at_popToRootViewControllerAnimated:));

        CATSwizzeMethod([self class], @selector(pushViewController:animated:),
                        @selector(at_pushViewController:animated:));
    });
}

- (void)at_undoDelegate
{
    self.delegate = self._delegate;
}

// viewDidLoad
- (void)at_viewDidLoad
{
    //设置动画代理
    self._delegate = [[CATNavigationControllerDelegate alloc] init];
    self.delegate = self._delegate;

    //设置手势
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;

    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];

    id target = gesture.delegate;
    [popRecognizer addTarget:self action:@selector(_handleControllerPop:)];
    popRecognizer.maximumNumberOfTouches = 1;
    popRecognizer.delaysTouchesBegan = YES;
    self._customPopGestureRecognizer = popRecognizer;

    //滑动触发距离
    self.at_interactiveMinMoveDistance = 200.0f;

    // viewDidLoad
    [self at_viewDidLoad];
}

// pop
- (UIViewController *)at_popViewControllerAnimated:(BOOL)animated
{
    if (!animated && [self _useCustomNavigationAnimation]) {
        [[CATPageManager shareManager] pop];
    }
    return [self at_popViewControllerAnimated:animated];
}
- (NSArray<UIViewController *> *)at_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray<__kindof UIViewController *> *viewControllers = [self at_popToViewController:viewController animated:animated];

    if ([self _useCustomNavigationAnimation]) {
        for (int i = 0; i < viewControllers.count - 1; i++) {
            [[CATPageManager shareManager] pop];
        }
        if (!animated) {
            [[CATPageManager shareManager] pop];
        }
    }
    return viewControllers;
}
- (NSArray<UIViewController *> *)at_popToRootViewControllerAnimated:(BOOL)animated
{
    NSArray<__kindof UIViewController *> *viewControllers = [self at_popToRootViewControllerAnimated:animated];

    if ([self _useCustomNavigationAnimation]) {
        for (int i = 0; (viewControllers.count > 0) && (i < viewControllers.count); i++) {
            [[CATPageManager shareManager] pop];
        }
        if (!animated) {
            [[CATPageManager shareManager] pop];
        }
    }
    return viewControllers;
}
//  add
- (NSArray<UIViewController *> *)popViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray<__kindof UIViewController *> *viewControllers = self.viewControllers;
    __block UIViewController *popToVC = nil;

    [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj isEqual:viewController]) {
            if (idx > 0) {
                popToVC = viewControllers[idx - 1];
            }
            *stop = YES;
        }
    }];

    if (popToVC) {
        return [self at_popToViewController:popToVC animated:animated];
    } else {
        return [self at_popToRootViewControllerAnimated:animated];
    }
}
// push
- (void)at_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self _useCustomNavigationAnimation]) {
        UIView *screem = self.tabBarController.view;
        if (!screem) {
            screem = self.view;
        }
        [[CATPageManager shareManager] push:[UIImage at_screenShotImageWithCaptureView:screem]];
    }
    [self at_pushViewController:viewController animated:animated];
}

#pragma mark - Delegate
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
//    NSLog(@"gestureRecognizer:%@ -- otherGesture:%@", gestureRecognizer, otherGestureRecognizer);
    if ([[otherGestureRecognizer view] isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)otherGestureRecognizer.view;
		CGPoint point;
		if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")]) {
			UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer *)otherGestureRecognizer;
			point = [panGestureRecognizer velocityInView:panGestureRecognizer.view];
//			NSLog(@"%@",NSStringFromCGPoint(point));
		}
        if (scrollView.contentOffset.x != 0 ||
			scrollView.frame.size.width == scrollView.contentSize.width ||
			point.x <= -80) {
            /*
			 1. 保证当scrollview 不能横向滑动的时候， 只能有一个手势响应。
             2. 当scrollview可以横向滑动时，当contentOffset.x != 0时,不允许两个同时滑动
			 */
            return NO;
        } else {
//			NSLog(@"-------------------YES");
            return YES;
        }
    }
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (!self._ableInteractivePop) {
        return NO;
    }
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (self.at_interactiveMinMoveDistance > 0 && beginningLocation.x > self.at_interactiveMinMoveDistance) {
        return NO;
    }
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    return YES;
}

#pragma mark - private methods
- (void)_handleControllerPop:(UIPanGestureRecognizer *)recognizer
{
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.at_interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        self._delegate.interactivePopTransition = self.at_interactivePopTransition;

        [CATPageManager shareManager].animationStatus = CATNavigationPopAnimationDrag;

        [self popViewControllerAnimated:YES];

    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.at_interactivePopTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded ||
               recognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.5) {
            [CATPageManager shareManager].animationStatus = CATNavigationPopAnimationDragFinished;
            [self.at_interactivePopTransition finishInteractiveTransition];
        } else {
            [CATPageManager shareManager].animationStatus = CATNavigationPopAnimationDragCalcelled;
            [self.at_interactivePopTransition cancelInteractiveTransition];
        }
        self.at_interactivePopTransition = nil;
    }
}
- (BOOL)_useCustomNavigationAnimation
{
    return self._delegate != nil;
}

CATAssociatedBoolProperty(_ableInteractivePop, _setAbleInteractivePop:);
CATAssociatedIntProperty(at_interactiveMinMoveDistance, at_setInteractiveMinMoveDistance:);
CATAssociatedProperty(_customPopGestureRecognizer, _setCustomPopGestureRecognizer:, UIPanGestureRecognizer *);
CATAssociatedProperty(_delegate, _setDelegate:, CATNavigationControllerDelegate *);
CATAssociatedProperty(at_interactivePopTransition, at_setInteractivePopTransition:, UIPercentDrivenInteractiveTransition *);

@end

NSMutableArray *CATDisableAtPropertyViewControllers(){
	static dispatch_once_t onceToken;
	static NSMutableArray *viewControllers = nil;
	dispatch_once(&onceToken, ^{
		viewControllers = [[NSMutableArray alloc] init];
	});
	return viewControllers;
}

@implementation UIViewController (CATNavigationController)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CATSwizzeMethod([self class],
                        @selector(viewWillAppear:),
                        @selector(at_viewWillAppear:));
    });
}
- (void)at_viewWillAppear:(BOOL)animated
{
    [self at_viewWillAppear:animated];

    [[UIApplication sharedApplication] setStatusBarStyle:self.at_statusBarStyle animated:YES];
	//当一个页面触发几个UIViewController的时候，这里容易出问题
	//感觉是错误的使用了UIViewController的原因。 有些地方并不需要使用到Controller的地步
    if ([self.navigationController isKindOfClass:[CATNavigationController class]] &&
        ![self isKindOfClass:NSClassFromString(@"GXQNetworkLoadingViewController")] &&
        ![self isKindOfClass:NSClassFromString(@"GXQNetworkFailedViewController")] &&
        ![self isKindOfClass:NSClassFromString(@"GXQTabBarController")]) {
		
        [self.navigationController setNavigationBarHidden:self.at_hiddenNavigationBar];
        [self.tabBarController.tabBar setHidden:!self.at_showTabBar];
		
		self.navigationController._ableInteractivePop = !self.at_disableInteractivePop;
		
		[self.navigationController.navigationBar at_setBackgroundColor:self.at_navigationBarBackgroundColor?:[[UINavigationBar appearance] backgroundColor]];
			
        if (self.at_navigationBarBottomLineColor) {
            [self.navigationController.navigationBar at_setBottomLineColor:self.at_navigationBarBottomLineColor];
        } else {
            [self.navigationController.navigationBar at_setBottomLineImage:[UINavigationBar appearance].shadowImage];
        }
    }
}
+ (void)at_customDisbaleAtPropertyForViewControllers:(NSArray *(^)())viewControllersBlock{
	if (viewControllersBlock) {
		NSArray *viewControllers = viewControllersBlock();
		if (viewControllers) {
			[CATDisableAtPropertyViewControllers() addObjectsFromArray:viewControllers];
		}
	}
}


CATAssociatedBoolProperty(at_hiddenNavigationBar, at_setHiddenNavigationBar:);
CATAssociatedBoolProperty(at_showTabBar, at_setShowTabBar:);
CATAssociatedBoolProperty(at_disableInteractivePop, at_setAbleInteractivePop:);
CATAssociatedIntProperty(at_statusBarStyle, at_setStatusBarStyle:);
CATAssociatedProperty(at_navigationBarBackgroundColor, at_setNavigationBarBackgroundColor:, UIColor *);
CATAssociatedProperty(at_navigationBarBottomLineColor, at_setNavigationBarBottomLineColor:, UIColor *);
CATAssociatedProperty(at_delegate, at_setDelegate:, id);
@end
