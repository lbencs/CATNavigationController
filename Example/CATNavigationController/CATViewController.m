//
//  CATViewController.m
//  CATNavigationController
//
//  Created by lbencs on 06/15/2016.
//  Copyright (c) 2016 lbencs. All rights reserved.
//

#import "CATViewController.h"
#import "CATChildViewController.h"
#import "CATNavigationController.h"
#import "UINavigationBar+CATCustom.h"

@interface CATViewController ()<UIScrollViewDelegate, CATNavigationControllerDelegate>
@end

@implementation CATViewController

- (void)viewDidLoad{
	[super viewDidLoad];
	self.title = @"History";
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
	self.at_showTabBar = YES;
	self.at_navigationBarBackgroundColor = [UIColor yellowColor];
	self.at_navigationBarBottomLineColor = [UIColor redColor];
	self.navigationController.at_delegate = self;
}
- (void)didReceiveMemoryWarning{
	[super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
}

#pragma mark - CATNavigationControllerDelegate
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
								   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
	return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
											animationControllerForOperation:(UINavigationControllerOperation)operation
														 fromViewController:(UIViewController *)fromVC
														   toViewController:(UIViewController *)toVC{
	return nil;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
	// Configure the cell...
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"%@",self.navigationController);
	CATChildViewController *nvc = [[CATChildViewController alloc] init];
//	[self.navigationController at_pushViewController:nvc animated:YES];
	[self.navigationController pushViewController:nvc animated:YES];
}
@end
