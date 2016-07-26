//
//  CATExpandTransitionAnimation.m
//  Pods
//
//  Created by lben on 6/17/16.
//
//

#import "CATExpandTransitionAnimation.h"

@implementation CATExpandTransitionAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
	return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
	
	UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	UIView *containerView = [transitionContext containerView];
	[containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
	NSTimeInterval duration = [self transitionDuration:transitionContext];
	
	toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
	UIView *mask = [[UIView alloc] initWithFrame:toViewController.view.bounds];
	[toViewController.view addSubview:mask];
	mask.backgroundColor = [UIColor blackColor];
	mask.alpha = 0.8;
	
	UINavigationController *nvc = (UINavigationController *)fromViewController.parentViewController;
	if (nvc) {
		NSLog(@"%@",nvc);
	}
	
	[UIView animateWithDuration:duration
					 animations:^{
						 
						 fromViewController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth([UIScreen mainScreen].bounds), 0);
						 toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
						 mask.alpha = 0.0f;
					 } completion:^(BOOL finished) {
						 [mask removeFromSuperview];
						 [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
					 }];
}

- (void)animationEnded:(BOOL)transitionCompleted{
}

@end
