//
//  CATDogChildViewController.m
//  CATNavigationController
//
//  Created by lben on 6/16/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

#import "CATDogChildViewController.h"
#import "CATNavigationController.h"

@interface CATDogChildViewController ()

@end

@implementation CATDogChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.at_hiddenNavigationBar = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 44);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)sender{
    UIViewController *vc = [[UIViewController alloc] init];
	vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController at_pushViewController:vc animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
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
