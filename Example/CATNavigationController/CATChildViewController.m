//
//  CATChildViewController.m
//  CATNavigationController
//
//  Created by lben on 6/16/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

#import "CATChildViewController.h"
#import "CATNavigationController.h"
#import "UINavigationBar+CATCustom.h"
@interface CATChildViewController ()
@property (nonatomic, weak) UIButton *button;
@end

static int i = 0;
@implementation CATChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next"
																			  style:0
																			 target:self
																			 action:@selector(next:)];
	
	self.title = @"Title";
	
	self.at_navigationBarBackgroundColor = [UIColor greenColor];
	self.at_navigationBarBottomLineColor = [UIColor blackColor];
	self.at_ableInteractivePop = (i % 2 == 0 );
	
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(50, 100, 300, 44);
	button.backgroundColor = [UIColor redColor];
	[self.view addSubview:button];
	[button setTitle:[NSString stringWithFormat:@"From%d Pop To Root",i] forState:UIControlStateNormal];
	[button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	_button = button;
	
	button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(50, 150, 300, 44);
	button.backgroundColor = [UIColor redColor];
	[self.view addSubview:button];
	[button setTitle:[NSString stringWithFormat:@"From%d Pop To Root No Animation",i] forState:UIControlStateNormal];
	[button addTarget:self action:@selector(btnClick4:) forControlEvents:UIControlEventTouchUpInside];
	
	
	button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(50, 200, 300, 44);
	button.backgroundColor = [UIColor redColor];
	[self.view addSubview:button];
	[button setTitle:[NSString stringWithFormat:@"Pop to %@",self.topVC] forState:UIControlStateNormal];
	[button addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
	
	button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(50, 300, 300, 44);
	button.backgroundColor = [UIColor redColor];
	[self.view addSubview:button];
	[button setTitle:[NSString stringWithFormat:@"Pop With No Animation"] forState:UIControlStateNormal];
	[button addTarget:self action:@selector(btnClick3:) forControlEvents:UIControlEventTouchUpInside];
	
	
	
	i ++;
}

- (void)btnClick3:(UIButton *)sender{
	[self.navigationController popViewControllerAnimated:NO];
}
- (void)btnClick2:(UIButton *)sender{
	if (self.topVC) {
		[self.navigationController at_popToViewController:self.topVC animated:YES];
	}
}


- (void)btnClick4:(UIButton *)sender{
	[self.navigationController at_popToRootViewControllerAnimated:NO];
}
- (void)btnClick:(UIButton *)sender{
	[self.navigationController at_popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)next:(id)sender{
	CATChildViewController *vc = [[CATChildViewController alloc] init];
	vc.topVC = self;
	if (i%2 == 0) {
		vc.view.backgroundColor = [UIColor whiteColor];
	}else{
		vc.view.backgroundColor = [UIColor grayColor];
	}
	[self.navigationController at_pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
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
