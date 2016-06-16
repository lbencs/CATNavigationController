//
//  CATNavigationTransitioningAnimationDefault.m
//  Pods
//
//  Created by lben on 6/15/16.
//
//

#import "CATNavigationTransitioningAnimationDefault.h"

@implementation CATNavigationTransitioningAnimationDefault


// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
	return 0.25;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
	
	UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	UIView *containerView = [transitionContext containerView];
	[containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
	NSTimeInterval duration = [self transitionDuration:transitionContext];
	
	toViewController.view.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth([UIScreen mainScreen].bounds), 0);
	
	[UIView animateWithDuration:duration
					 animations:^{
						 fromViewController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth([UIScreen mainScreen].bounds), 0);
						 toViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
					 } completion:^(BOOL finished) {
						 [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
					 }];
}

- (void)animationEnded:(BOOL)transitionCompleted{
}


@end
