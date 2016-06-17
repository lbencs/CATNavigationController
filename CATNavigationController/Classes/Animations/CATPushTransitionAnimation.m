//
//  CATPushTransitionAnimation.m
//  Pods
//
//  Created by lben on 6/17/16.
//
//

#import "CATPushTransitionAnimation.h"
#import "CATProvider.h"

@implementation CATPushTransitionAnimation
- (CGFloat)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
	return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
	
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	CGFloat duration = [self transitionDuration:transitionContext];
	UIView *containerView = [transitionContext containerView];

	CGRect finalFrameFormVc = [transitionContext finalFrameForViewController:toVC];
	toVC.view.frame = finalFrameFormVc;
	[containerView addSubview:toVC.view];
	
//	toVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.85, 0.85);
//	toVC.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -[UIScreen mainScreen].bounds.size.width, 0);
	UIImage *fromVcImage = [[CATPageManager shareManager] firstObjc];
	UIImageView *fromVcCover = [[UIImageView alloc] initWithImage:fromVcImage];
	fromVcCover.frame = [UIScreen mainScreen].bounds;
	UIView *bottomView = [[UIView alloc] initWithFrame:containerView.bounds];
	bottomView.backgroundColor = [UIColor blackColor];
	
	[containerView insertSubview:bottomView aboveSubview:fromVC.view];
	[containerView insertSubview:fromVcCover aboveSubview:bottomView];
	
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
						  delay:0.0
		 usingSpringWithDamping:0.0
		  initialSpringVelocity:0.0
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 fromVC.view.alpha = 0.8;
//						 fromVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.85, 0.85);
						 fromVcCover.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.85, 0.85);
//						 toVC.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
					 } completion:^(BOOL finished) {
						 fromVC.view.alpha = 1.0;
						 fromVC.view.transform = CGAffineTransformIdentity;
						 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
					 }];
	
//	[containerView insertSubview:fromVC.view belowSubview:toVC.view];

//	UINavigationBar *navBar = fromVC.navigationController.navigationBar;
//	
//	NSLog(@"%@",[NSDate date]);
//	UIImage *fromVcScreenshot = [UIImage at_screenShotImageWithCaptureView:fromVC.tabBarController.view];
//	UIImage *toVcScreenshot = [[CATPageManager shareManager] pop];
//	NSLog(@"%@",[NSDate date]);
//	
//	UIImageView *fromVcCover = [[UIImageView alloc] initWithImage:fromVcScreenshot];
//	fromVcCover.bounds = fromVC.view.bounds;
//	[fromVC.view addSubview:fromVcCover];
//	
//	UIImageView *toVcCover = [[UIImageView alloc] initWithImage:toVcScreenshot];
//	toVcCover.bounds = containerView.bounds;
//	
//	UIView *bottomView = [[UIView alloc] initWithFrame:containerView.bounds];
//	bottomView.backgroundColor = [UIColor blackColor];
//	[containerView insertSubview:toVcCover belowSubview:fromVC.view];
//	[containerView insertSubview:bottomView belowSubview:toVcCover];
//	
//	toVcCover.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.85, 0.85);
//	
//	[toVC.navigationController setNavigationBarHidden:YES];
//	toVC.tabBarController.tabBar.hidden = YES;
//	
//	[UIView animateWithDuration:duration
//					 animations:^{
//						 fromVC.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth([UIScreen mainScreen].bounds), 0);
//						 toVcCover.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
//					 } completion:^(BOOL finished) {
//						 [fromVcCover removeFromSuperview];
//						 [toVcCover removeFromSuperview];
//						 [bottomView removeFromSuperview];
//						 
//						 [toVC.navigationController setNavigationBarHidden:NO];
//						 toVC.tabBarController.tabBar.hidden = NO;
//						 [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//					 }];
}

- (void)animationEnded:(BOOL)transitionCompleted{
	
}

@end
