//
//  CATWrapViewController.m
//  Pods
//
//  Created by lben on 6/16/16.
//
//

#import "CATWrapViewController.h"
#import "CATCoreNavigationController.h"
#import "CATProvider.h"

@implementation CATWrapNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
	if (self = [super init]) {
		self.viewControllers = @[rootViewController];
	}
	return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
	//自定义返回按钮
	 viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage at_imageWithColor:[UIColor blackColor] withSize:CGSizeMake(20, 20)] style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
	
	[[CATCoreNavigationController shareNavigationController] pushViewController:[CATWrapViewController wrapWithViewController:viewController] animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
	return [[CATCoreNavigationController shareNavigationController] popViewControllerAnimated:animated];
}
//- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
//}
- (void)didTapBackButton{
	[[CATCoreNavigationController shareNavigationController] popViewControllerAnimated:YES];
}

@end

@interface CATWrapViewController ()
@property (nonatomic, strong, readwrite) __kindof UIViewController *contentViewController;
@property (nonatomic, strong) UINavigationController *containerNavigationController;

@end

@implementation CATWrapViewController

+ (CATWrapViewController *)wrapWithViewController:(UIViewController *)viewController{
	
	CATWrapNavigationController *wrapNavigationController = [[CATWrapNavigationController alloc] init];
	wrapNavigationController.viewControllers = @[viewController];
	
	CATWrapViewController *vc = [[CATWrapViewController alloc] init];
	vc.contentViewController = viewController;
	
	[vc.view addSubview:wrapNavigationController.view];
	[vc addChildViewController:wrapNavigationController];
	
	return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
