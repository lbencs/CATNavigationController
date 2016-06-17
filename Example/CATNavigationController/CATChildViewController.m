//
//  CATChildViewController.m
//  CATNavigationController
//
//  Created by lben on 6/16/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

#import "CATChildViewController.h"
#import "UINavigationBar+CATCustom.h"

@interface CATChildViewController ()

@end

@implementation CATChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor blueColor];
	
	UIToolbar *toolBar = [[UIToolbar alloc] init];
	
	toolBar.frame = CGRectMake(CGRectGetHeight(self.view.frame) - 40,
							   100,
							   CGRectGetWidth([UIScreen mainScreen].bounds),
							   40);
	
//	UIBarButtonItem *item = [[UIBarButtonItem alloc] initwith]
	toolBar.backgroundColor = [UIColor redColor];
	[self.view addSubview:toolBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar at_setBackgroundColor:[UIColor greenColor]];
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
