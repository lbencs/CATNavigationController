//
//  CATPopTransitionAnimation.m
//  Pods
//
//  Created by lben on 6/17/16.
//
//

#import "CATPopTransitionAnimation.h"
#import "CATProvider.h"

@implementation CATPopTransitionAnimation

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
	
    [super animateTransition:transitionContext];
    
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	CGFloat duration = [self transitionDuration:transitionContext];
	UIView *containerView = [transitionContext containerView];
	
	[containerView insertSubview:toVC.view belowSubview:fromVC.view];
	
	//黑色背景
	UIView *bottomView = [[UIView alloc] initWithFrame:containerView.bounds];
	bottomView.backgroundColor = [UIColor blackColor];
	[containerView insertSubview:bottomView belowSubview:fromVC.view];
	
	NSLog(@"%@",[NSDate date]);
	UIImage *fromVcScreenshot = [UIImage at_screenShotImageWithCaptureView:toVC.tabBarController.view];
	if (!fromVcScreenshot) {
		fromVcScreenshot = [UIImage at_screenShotImageWithCaptureView:toVC.navigationController.view];
	}
	UIImage *toVcScreenshot = [[CATPageManager shareManager] firstObjc];
	NSLog(@"%@",[NSDate date]);
	
	UIImageView *fromVcCover = [[UIImageView alloc] initWithImage:fromVcScreenshot];
	fromVcCover.bounds = containerView.bounds;
	[containerView addSubview:fromVcCover];
	
	UIImageView *toVcCover = [[UIImageView alloc] initWithImage:toVcScreenshot];
	toVcCover.bounds = containerView.bounds;
	[containerView insertSubview:toVcCover belowSubview:fromVC.view];
	
	toVcCover.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
	
	UINavigationBar *navigationBar = toVC.navigationController.navigationBar;
	navigationBar.transform = CGAffineTransformMakeTranslation(0, -100);
	[toVC.tabBarController.tabBar at_setAlpha:0.0];
	
	[UIView animateWithDuration:duration
					 animations:^{
						 fromVcCover.transform = CGAffineTransformMakeTranslation(CGRectGetWidth([UIScreen mainScreen].bounds), 0);
						 fromVC.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth([UIScreen mainScreen].bounds), 0);
						 toVcCover.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
					 } completion:^(BOOL finished) {
						 [fromVcCover removeFromSuperview];
						 [toVcCover removeFromSuperview];
						 [bottomView removeFromSuperview];
						 navigationBar.transform = CGAffineTransformMakeTranslation(0,0);
						 [toVC.tabBarController.tabBar at_setAlpha:1.0];
						 [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
					 }];
}

@end
