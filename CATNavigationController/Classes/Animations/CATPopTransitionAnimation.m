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


- (CGFloat)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
	return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
	
    [super animateTransition:transitionContext];
    
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	CGFloat duration = [self transitionDuration:transitionContext];
	UIView *containerView = [transitionContext containerView];
	
	[containerView insertSubview:toVC.view belowSubview:fromVC.view];
	
	UINavigationBar *navBar = fromVC.navigationController.navigationBar;
	
	NSLog(@"%@",[NSDate date]);
	UIImage *fromVcScreenshot = [UIImage at_screenShotImageWithCaptureView:fromVC.tabBarController.view];
	UIImage *toVcScreenshot = [[CATPageManager shareManager] firstObjc];
	NSLog(@"%@",[NSDate date]);
	
	UIImageView *fromVcCover = [[UIImageView alloc] initWithImage:fromVcScreenshot];
	fromVcCover.bounds = fromVC.view.bounds;
	[fromVC.view addSubview:fromVcCover];
	
	UIImageView *toVcCover = [[UIImageView alloc] initWithImage:toVcScreenshot];
	toVcCover.bounds = containerView.bounds;
	
	UIView *bottomView = [[UIView alloc] initWithFrame:containerView.bounds];
	bottomView.backgroundColor = [UIColor blackColor];
	[containerView insertSubview:toVcCover belowSubview:fromVC.view];
	[containerView insertSubview:bottomView belowSubview:toVcCover];
	
	toVcCover.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.95);
	
	[toVC.navigationController setNavigationBarHidden:YES];
	toVC.tabBarController.tabBar.hidden = YES;
 	[UIView animateWithDuration:duration
					 animations:^{
						 fromVC.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth([UIScreen mainScreen].bounds), 0);
						 toVcCover.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
					 } completion:^(BOOL finished) {
						 [fromVcCover removeFromSuperview];
						 [toVcCover removeFromSuperview];
						 [bottomView removeFromSuperview];
						 [toVC.navigationController setNavigationBarHidden:NO];
						 toVC.tabBarController.tabBar.hidden = NO;
						 [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
					 }];
}

@end
