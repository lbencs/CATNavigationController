//
//  CATCoreNavigationController.m
//  Pods
//
//  Created by lben on 6/16/16.
//
//

#import "CATCoreNavigationController.h"
#import "CATWrapViewController.h"

@interface CATCoreWrapViewController : UIViewController
@end

@implementation CATCoreWrapViewController
- (UIViewController *)childViewControllerForStatusBarStyle {
	return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
	return [self rootViewController];
}

- (UIViewController *)rootViewController {
	return self.childViewControllers.firstObject;
}
@end


@interface CATCoreNavigationController ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;
@end

@implementation CATCoreNavigationController

+ (CATCoreNavigationController *)shareNavigationController{
	static dispatch_once_t onceToken;
	static CATCoreNavigationController *nvc = nil;
	dispatch_once(&onceToken, ^{
		nvc = [[CATCoreNavigationController alloc] init];
	});
	return nvc;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
	CATCoreNavigationController *nvc = [CATCoreNavigationController shareNavigationController];
	nvc.viewControllers = @[rootViewController];
	return nvc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setNavigationBarHidden:YES animated:NO];
	
	id target = self.interactivePopGestureRecognizer.delegate;
	SEL action = NSSelectorFromString(@"handleNavigationTransition:");
	self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
	[self.view addGestureRecognizer:self.popPanGesture];
	self.popPanGesture.maximumNumberOfTouches = 1;
	self.interactivePopGestureRecognizer.enabled = NO;
}

/**
 *  我们把用户的每次Pan手势操作作为一次pop动画的执行
 */
- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer {
	/**
	 *  interactivePopTransition就是我们说的方法2返回的对象，我们需要更新它的进度来控制Pop动画的流程，我们用手指在视图中的位置与视图宽度比例作为它的进度。
	 */
	CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
	/**
	 *  稳定进度区间，让它在0.0（未完成）～1.0（已完成）之间
	 */
	progress = MIN(1.0, MAX(0.0, progress));
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		/**
		 *  手势开始，新建一个监控对象
		 */
		self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
		/**
		 *  告诉控制器开始执行pop的动画
		 */
		[self popViewControllerAnimated:YES];
	}
	else if (recognizer.state == UIGestureRecognizerStateChanged) {
		
		/**
		 *  更新手势的完成进度
		 */
		[self.interactivePopTransition updateInteractiveTransition:progress];
	}
	else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
		
		/**
		 *  手势结束时如果进度大于一半，那么就完成pop操作，否则重新来过。
		 */
		if (progress > 0.5) {
			[self.interactivePopTransition finishInteractiveTransition];
		}
		else {
			[self.interactivePopTransition cancelInteractiveTransition];
		}
		
		self.interactivePopTransition = nil;
	}
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
