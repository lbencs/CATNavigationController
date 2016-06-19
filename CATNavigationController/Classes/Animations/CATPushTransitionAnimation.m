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
	return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    [super animateTransition:transitionContext];
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	CGFloat duration = [self transitionDuration:transitionContext];
	UIView *containerView = [transitionContext containerView];

	CGRect finalFrameFormVc = [transitionContext finalFrameForViewController:toVC];
	toVC.view.frame = finalFrameFormVc;
	
//	toVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.85, 0.85);
//	toVC.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -[UIScreen mainScreen].bounds.size.width, 0);
	UIImage *fromVcImage = [[CATPageManager shareManager] firstObjc];
	UIImageView *fromVcCover = [[UIImageView alloc] initWithImage:fromVcImage];
	fromVcCover.frame = [UIScreen mainScreen].bounds;
    
    UIImage *toVcImage = [UIImage at_screenShotImageWithCaptureView:toVC.view];
    UIImageView *toVcCover = [[UIImageView alloc] initWithImage:fromVcImage];
    toVcCover.frame = [UIScreen mainScreen].bounds;
    
    
	UIView *bottomView = [[UIView alloc] initWithFrame:containerView.bounds];
	bottomView.backgroundColor = [UIColor blackColor];
//    [containerView addSubview:toVC.view];
    
    UINavigationController *nvc = toVC.navigationController;
    nvc.navigationBar.hidden = YES;
    nvc.tabBarController.tabBar.hidden = YES;
    
    [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
    [containerView addSubview:bottomView];
    [containerView addSubview:fromVcCover];
    [containerView bringSubviewToFront:toVC.view];
//    [containerView addSubview:toVcCover];
    
    
//	[containerView insertSubview:bottomView aboveSubview:fromVC.view];
//	[containerView insertSubview:fromVcCover aboveSubview:bottomView];
    
    toVC.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(toVC.view.frame) + 150, 0);
//    toVcCover.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(toVcCover.frame) + 300, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromVC.view.alpha = 0.8;
                         //						 fromVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.85, 0.85);
                         fromVcCover.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.88, 0.90);
                         //						 toVC.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
                         toVC.view.transform = CGAffineTransformIdentity;
//                         toVcCover.transform = CGAffineTransformMakeTranslation(0, 0);
                         
                     } completion:^(BOOL finished) {
                         nvc.navigationBar.hidden = NO;
                         nvc.tabBarController.tabBar.hidden = NO;
                         [bottomView removeFromSuperview];
                         [fromVcCover removeFromSuperview];
                         [toVcCover removeFromSuperview];
                         fromVC.view.alpha = 1.0;
                         fromVC.view.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         
                     }];
//    
//	[UIView animateWithDuration:[self transitionDuration:transitionContext]
//						  delay:0.0
//		 usingSpringWithDamping:0.0
//		  initialSpringVelocity:0.0
//						options:UIViewAnimationOptionCurveEaseIn
//					 animations:^{
//						 fromVC.view.alpha = 0.8;
////						 fromVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.85, 0.85);
//						 fromVcCover.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.88, 0.90);
////						 toVC.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
////                         toVC.view.transform = CGAffineTransformIdentity;
//                         toVcCover.transform = CGAffineTransformMakeTranslation(0, 0);
//					 } completion:^(BOOL finished) {
//                         nvc.navigationBar.hidden = NO;
//                         nvc.tabBarController.tabBar.hidden = NO;
//                         [bottomView removeFromSuperview];
//                         [fromVcCover removeFromSuperview];
//                         [toVcCover removeFromSuperview];
//						 fromVC.view.alpha = 1.0;
//						 fromVC.view.transform = CGAffineTransformIdentity;
//						 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//					 }];
//	
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


@end
