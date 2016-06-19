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
#import "UIViewController+CATNavigationController.h"

typedef NS_ENUM(NSInteger, CATNavigationPopAnimation) {
    CATNavigationPopAnimationPop,
    CATNavigationPopAnimationDrag,
    CATNavigationPopAnimationDragCalcelled,
    CATNavigationPopAnimationDragFinished
};


@interface CATNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;


@property (nonatomic, assign) CATNavigationPopAnimation popAnimation;


@end

@implementation CATNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.delegate = self;
//
//
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
	CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
	CGFloat maxAllowedInitialDistance = 200;
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

- (UIViewController *)at_popViewControllerAnimated:(BOOL)animated{
	return [super popViewControllerAnimated:animated];
}
- (void)at_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
	return [super pushViewController:viewController animated:animated];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
    if (self.tabBarController) {
        [[CATPageManager shareManager] push:[UIImage at_screenShotImageWithCaptureView:self.tabBarController.view]];
    }else if(self.navigationController){
        [[CATPageManager shareManager] push:[UIImage at_screenShotImageWithCaptureView:self.navigationController]];
    }else{
//        [[CATPageManager shareManager] ]
    }
	
//    [[[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil] show];
    
	[super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
//    [CATransaction begin];
//    [CATransaction setCompletionBlock:^{
//        NSLog(@"%@",@"Pop Finished");
//        [[CATPageManager shareManager] pop];
//    }];
   UIViewController *vc = [super popViewControllerAnimated:animated];
//    [CATransaction commit];
    
    return vc;
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
        _popAnimation = CATNavigationPopAnimationDrag;
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
            _popAnimation = CATNavigationPopAnimationDragFinished;
            [self.interactivePopTransition finishInteractiveTransition];
        }
		else {
            _popAnimation = CATNavigationPopAnimationDragCalcelled;
			[self.interactivePopTransition cancelInteractiveTransition];
		}
		
		self.interactivePopTransition = nil;
	}
}


#pragma mark - UINavigationControllerDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//	
//}
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//	
//}
//
//- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController{
//	return nil;
//}
//- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController{
//	return nil;
//}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
	if (operation == UINavigationControllerOperationPop) {
		NSLog(@"pop");
        return [[CATPopTransitionAnimation alloc] initWithBegin:^(id<UIViewControllerContextTransitioning> transitionContext) {
        
        } completion:^{
            
            if (_popAnimation == CATNavigationPopAnimationDragFinished ||
                _popAnimation == CATNavigationPopAnimationPop) {
                
                [[CATPageManager shareManager] pop];
                _popAnimation = CATNavigationPopAnimationPop;
            }
            
        }];
	}else if (operation = UINavigationControllerOperationPush){
		NSLog(@"push");
		return [[CATPushTransitionAnimation alloc] initWithBegin:^(id<UIViewControllerContextTransitioning> transitionContext) {
        } completion:^{
            [toVC.navigationController setNavigationBarHidden:toVC.at_hiddenNavigationBar];
            toVC.tabBarController.tabBar.hidden = !toVC.at_showTabBar;
        }];
        
        return nil;
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


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
