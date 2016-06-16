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
	CATCoreWrapViewController *wrapVc = [[CATCoreWrapViewController alloc] init];
	[wrapVc.view addSubview:rootViewController.view];
	[wrapVc addChildViewController:rootViewController];
	nvc.viewControllers = @[wrapVc];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
