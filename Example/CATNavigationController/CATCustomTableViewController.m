//
//  CATCustomTableViewController.m
//  CATNavigationController
//
//  Created by lbencs on 8/2/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

#import "CATCustomTableViewController.h"
#import "CATChildViewController.h"
#import "CATNavigationController.h"
#import "CATCustomChildViewController.h"

@interface CATCustomTableViewController ()<UINavigationControllerDelegate>
@property (nonatomic, weak) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@end

@interface CATPushAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, weak) UIView *animationView;
@end
@implementation CATPushAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return .25;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *container = [transitionContext containerView];
    
    [container addSubview:toView];
    
    CGRect frame = self.animationView.frame;
    toView.alpha = 0.f;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.animationView.frame = CGRectMake(15, 69, 300, 200);
                         
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0
                                          animations:^{
                                              toView.alpha = 1.0f;
                                          } completion:^(BOOL finished) {
                                              fromView.alpha = 1.0f;
                                              self.animationView.frame = frame;
                                              [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                                          }];
                     }];
}
- (void)animationEnded:(BOOL) transitionCompleted
{
    
}
@end


@interface CATCustomTableViewController ()
@property (nonatomic, weak) UIView *animationView;
@end

@implementation CATCustomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"History";
    self.at_showTabBar = YES;
    self.navigationController.delegate = self;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 100, 150, 100);
    [button setBackgroundColor:[UIColor brownColor]];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 210, 150, 100);
    [button setBackgroundColor:[UIColor brownColor]];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 320, 150, 100);
    [button setBackgroundColor:[UIColor brownColor]];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 430, 150, 100);
    [button setBackgroundColor:[UIColor brownColor]];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController at_undoDelegate];
}

- (void)btnClick:(UIButton *)sender
{
    self.animationView = sender;
    CATCustomChildViewController *vc = [[CATCustomChildViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{}
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
       
    } else if (operation == UINavigationControllerOperationPush) {
        CATPushAnimation *animation = [[CATPushAnimation alloc] init];
        animation.animationView = self.animationView;
        return animation;
    } else if (operation == UINavigationControllerOperationNone) {
        NSLog(@"none");
    }
    
    return nil;
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
//    if ([animationController isKindOfClass:[CATPopTransitionAnimation class]]) {
//    return self.navigationController.at_interactivePopTransition;
//    } else if ([animationController isKindOfClass:[CATPushTransitionAnimation class]]) {
//        return nil;
//    }
    return nil;
}
- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    return UIInterfaceOrientationMaskAll;
}
//- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController
//{
//    return UIInterfaceOrientationMaskAll;
//}
@end
