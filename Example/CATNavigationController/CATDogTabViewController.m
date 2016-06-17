//
//  CATDogTabViewController.m
//  CATNavigationController
//
//  Created by lben on 6/15/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

#import "CATDogTabViewController.h"
#import "CATDogChildViewController.h"
#import "UINavigationBar+CATCustom.h"

@interface CATDogTabViewController ()

@end

@implementation CATDogTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"More";
	
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
	[self.navigationController.navigationBar at_setBottomLineColor:[UIColor redColor]];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:animated];
	self.navigationController.tabBarController.tabBar.hidden = NO;

	[self.navigationController.navigationBar at_setBackgroundColor:[UIColor whiteColor]];
//	self.hidesBottomBarWhenPushed = YES;
//	self.tabBarController.tabBar.hidden = NO;
//	self.tabBarController.hidesBottomBarWhenPushed = YES;
//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//		[self.navigationController.navigationBar at_undo];
//	});
}
- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
//	self.accessibilityElementsHidden = NO;
	[self.navigationController.navigationBar at_undo];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
	// Configure the cell...
	
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"%@",self.navigationController);
	CATDogChildViewController *nvc = [[CATDogChildViewController alloc] init];
	if (indexPath.row == 0) {
		[self.navigationController  pushViewController:nvc animated:YES];
	}else{
		nvc.view.backgroundColor = [UIColor yellowColor];
		[self.navigationController pushViewController:nvc animated:YES];
	}
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
