//
//  CATWrapViewController.m
//  Pods
//
//  Created by lben on 6/16/16.
//
//

#import "CATWrapViewController.h"
#import "CATCoreNavigationController.h"
#import "UIImage+CATOO.h"

@interface CATWrapNavigationController : UINavigationController

@end
@implementation CATWrapNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
	 viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage at_imageWithColor:[UIColor blackColor] withSize:CGSizeMake(20, 20)] style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
	
	[[CATCoreNavigationController shareNavigationController] pushViewController:[CATWrapViewController wrapWithViewController:viewController] animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
	return [[CATCoreNavigationController shareNavigationController] popViewControllerAnimated:animated];
}

- (void)didTapBackButton{
	[[CATCoreNavigationController shareNavigationController] popViewControllerAnimated:YES];
}

@end

@interface CATWrapViewController ()

@end

@implementation CATWrapViewController

+ (CATWrapViewController *)wrapWithViewController:(UIViewController *)viewController{
	
	CATWrapNavigationController *wrapNavigationController = [[CATWrapNavigationController alloc] init];
	wrapNavigationController.viewControllers = @[viewController];
	
	CATWrapViewController *vc = [[CATWrapViewController alloc] init];
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
