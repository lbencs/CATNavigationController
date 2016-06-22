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
#import "CATNavigationTransitioningAnimationDefault.h"
#import "CATPopTransitionAnimation.h"
#import "CATPushTransitionAnimation.h"
#import "CATProvider.h"
#import "UINavigationBar+CATCustom.h"

typedef NS_ENUM(NSInteger, CATNavigationPopAnimation) {
	CATNavigationPopAnimationPop,
	CATNavigationPopAnimationDrag,
	CATNavigationPopAnimationDragCalcelled,
	CATNavigationPopAnimationDragFinished
};


@interface CATNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property (nonatomic, weak) UIPanGestureRecognizer *customPopGestureRecognizer;

@property (nonatomic, assign) CATNavigationPopAnimation popAnimation;
@end


@implementation CATNavigationController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.delegate = self;
	
	UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
	gesture.enabled = NO;
	UIView *gestureView = gesture.view;
	
	UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
	popRecognizer.delegate = self;
	popRecognizer.maximumNumberOfTouches = 1;
	[gestureView addGestureRecognizer:popRecognizer];
	
	id target = gesture.delegate;
	SEL action = NSSelectorFromString(@"handleNavigationTransition:");
#if 0
	[popRecognizer addTarget:target action:action];
#else
	[popRecognizer addTarget:self action:@selector(handleControllerPop:)];
#endif
	popRecognizer.maximumNumberOfTouches = 1;
	
	self.customPopGestureRecognizer = popRecognizer;
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - Delegate
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
	return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
	
	CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
	CGFloat maxAllowedInitialDistance = self.at_interactiveMinMoveDistance;
	if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
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

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
	if (operation == UINavigationControllerOperationPop) {
		return [[CATPopTransitionAnimation alloc] initWithCompletion:^{
			if (_popAnimation == CATNavigationPopAnimationDragFinished ||
				_popAnimation == CATNavigationPopAnimationPop) {
				
				[[CATPageManager shareManager] pop];
				_popAnimation = CATNavigationPopAnimationPop;
			}
		}];
	}else if (operation = UINavigationControllerOperationPush){
		return [[CATPushTransitionAnimation alloc] init];
	}else if (operation == UINavigationControllerOperationNone){
		NSLog(@"none");
	}
	
	return nil;
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
	if ([animationController isKindOfClass:[CATPopTransitionAnimation class]]) {
		return self.interactivePopTransition;
	}else if ([animationController isKindOfClass:[CATPushTransitionAnimation class]]){
		return nil;
	}
	return nil;
}
- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController{
	return UIInterfaceOrientationMaskAll;
}
- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController{
	return UIInterfaceOrientationMaskAll;
}

#pragma mark - private methods

- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer {
	
	CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
	
	progress = MIN(1.0, MAX(0.0, progress));
	
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		
		self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
		
		_popAnimation = CATNavigationPopAnimationDrag;
		
		[self popViewControllerAnimated:YES];
		
	}else if (recognizer.state == UIGestureRecognizerStateChanged) {
		
		[self.interactivePopTransition updateInteractiveTransition:progress];
		
	}else if (recognizer.state == UIGestureRecognizerStateEnded ||
			  recognizer.state == UIGestureRecognizerStateCancelled) {
		
		if (progress > 0.5) {
			_popAnimation = CATNavigationPopAnimationDragFinished;
			[self.interactivePopTransition finishInteractiveTransition];
		}else {
			_popAnimation = CATNavigationPopAnimationDragCalcelled;
			[self.interactivePopTransition cancelInteractiveTransition];
		}
		self.interactivePopTransition = nil;
	}
}
@end


#import <objc/runtime.h>

@implementation UINavigationController (CATNavigationController)

+ (void)load{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		CATSwizzeMethod([self class],
						@selector(popViewControllerAnimated:),
						@selector(at_popViewControllerAnimated:));
	});
}
// pop
- (UIViewController *)at_popViewControllerAnimated:(BOOL)animated{
	if (!animated) {
		[[CATPageManager shareManager] pop];
	}
	return [self at_popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)at_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
	NSArray <__kindof UIViewController *> *viewControllers = [self popToViewController:viewController animated:animated];
	
	for (int i = 0; i < viewControllers.count -1; i ++) {
		[[CATPageManager shareManager] pop];
	}
	if (!animated) {
		[[CATPageManager shareManager] pop];
	}
	return viewControllers;
}

- (NSArray<UIViewController *> *)at_popViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
	NSArray <__kindof UIViewController *> *viewControllers = self.viewControllers;
	
	__block UIViewController *popToVC = nil;
	
	[viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([obj isEqual:viewController]) {
			if (idx > 0) {
				popToVC = viewControllers[idx - 1];
			}
			*stop = YES;
		}
	}];
	if (popToVC) {
		return [self at_popToViewController:popToVC animated:animated];
	}else{
		return [self at_popToRootViewControllerAnimated:animated];
	}
}

- (NSArray<UIViewController *> *)at_popToRootViewControllerAnimated:(BOOL)animated{
	
	NSArray<__kindof UIViewController *> *viewControllers = [self popToRootViewControllerAnimated:animated];
	
	for (int i = 0; i < viewControllers.count -1; i ++) {
		[[CATPageManager shareManager] pop];
	}
	if (!animated) {
		[[CATPageManager shareManager] pop];
	}
	return viewControllers;
}

// push
- (void)at_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
	UIView *screem = self.tabBarController.view;
	
	if (!screem) {
		screem = self.view;
	}
	[[CATPageManager shareManager] push:[UIImage at_screenShotImageWithCaptureView:screem]];
	
	[self pushViewController:viewController animated:animated];
}

// getter && setter
- (CGFloat)at_interactiveMinMoveDistance{
	NSNumber *distance = objc_getAssociatedObject(self, _cmd);
	if (distance) {
		return [distance floatValue];
	}
	return 200.00;
}
- (void)at_setInteractiveMinMoveDistance:(CGFloat)at_interactiveMinMoveDistance{
	objc_setAssociatedObject(self, @selector(at_interactiveMinMoveDistance), @(at_interactiveMinMoveDistance), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@implementation UIViewController (CATNavigationController)

+ (void)load{
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		CATSwizzeMethod([self class],
						@selector(viewWillAppear:),
						@selector(at_viewWillAppear:));
	});
	
}

- (void)at_viewWillAppear:(BOOL)animated{
	[self at_viewWillAppear:animated];
	
	[self.navigationController setNavigationBarHidden:self.at_hiddenNavigationBar];
	
	[self.tabBarController.tabBar setHidden:!self.at_showTabBar];
	
//	CATNavigationController *navigationController = (CATNavigationController *)self.navigationController;
//	navigationController.customPopGestureRecognizer.enabled = self.at_ableInteractivePop;
	
	if (self.at_navigationBarBackgroundColor) {
		[self.navigationController.navigationBar at_setBackgroundColor:self.at_navigationBarBackgroundColor];
	}else{
		[self.navigationController.navigationBar at_setBackgroundColor:[UINavigationBar appearance].backgroundColor];
	}
	if (self.at_navigationBarBottomLineColor) {
		[self.navigationController.navigationBar at_setBottomLineColor:self.at_navigationBarBottomLineColor];
	}else{
		[self.navigationController.navigationBar at_setBottomLineColor:[UINavigationBar appearance].backgroundColor];
	}
}

- (BOOL)at_hiddenNavigationBar{
	return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)at_setHiddenNavigationBar:(BOOL)at_hiddenNavigationBar{
	objc_setAssociatedObject(self, @selector(at_hiddenNavigationBar), @(at_hiddenNavigationBar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)at_showTabBar{
	return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)at_setShowTabBar:(BOOL)at_showTabBar{
	objc_setAssociatedObject(self, @selector(at_showTabBar), @(at_showTabBar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)at_navigationBarBackgroundColor{
	return objc_getAssociatedObject(self, _cmd);
}
- (void)at_setNavigationBarBackgroundColor:(UIColor *)at_navigationBarBackgroundColor{
	objc_setAssociatedObject(self, @selector(at_navigationBarBackgroundColor), at_navigationBarBackgroundColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)at_navigationBarBottomLineColor{
	return objc_getAssociatedObject(self, _cmd);
}
- (void)at_setNavigationBarBottomLineColor:(UIColor *)at_navigationBarBottomLineColor{
	objc_setAssociatedObject(self, @selector(at_navigationBarBottomLineColor), at_navigationBarBottomLineColor, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)at_ableInteractivePop{
	NSNumber *able = objc_getAssociatedObject(self, _cmd);
	if (able) {
		return [able boolValue];
	}
	return YES;
}
- (void)at_setAbleInteractivePop:(BOOL)at_ableInteractivePop{
	objc_setAssociatedObject(self, @selector(at_ableInteractivePop), @(at_ableInteractivePop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end