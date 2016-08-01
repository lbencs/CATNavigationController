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

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [super animateTransition:transitionContext];

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];

    //view
    CGRect finalFrameFormVc = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = finalFrameFormVc;


    UIView *bottomView = [[UIView alloc] initWithFrame:containerView.bounds];
    bottomView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:bottomView];

    UIImage *fromVcImage = [[CATPageManager shareManager] firstObjc];
    UIImageView *fromVcCover = [[UIImageView alloc] initWithImage:fromVcImage];
    fromVcCover.frame = [UIScreen mainScreen].bounds;
    [containerView addSubview:fromVcCover];
    [containerView addSubview:toVC.view];

    UINavigationBar *navigationBar = toVC.navigationController.navigationBar;
    UITabBar *tabBar = toVC.tabBarController.tabBar;

    CGAffineTransform transformPadding =
        CGAffineTransformMakeTranslation(CGRectGetWidth([UIScreen mainScreen].bounds), 0);
    toVC.view.transform = transformPadding;
    navigationBar.transform = transformPadding;
    tabBar.transform = transformPadding;

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
        animations:^{
            navigationBar.transform = CGAffineTransformIdentity;
            tabBar.transform = CGAffineTransformIdentity;
            fromVcCover.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
            toVC.view.transform = CGAffineTransformIdentity;

        }
        completion:^(BOOL finished) {
            [bottomView removeFromSuperview];
            [fromVcCover removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
}


@end
