//
//  CATViewController.m
//  CATNavigationController
//
//  Created by lbencs on 06/15/2016.
//  Copyright (c) 2016 lbencs. All rights reserved.
//

#import "CATViewController.h"
#import "CATChildViewController.h"
#import "UINavigationBar+CATCustom.h"

@interface CATViewController ()<UIScrollViewDelegate>
@end

@implementation CATViewController

- (void)viewDidLoad{
	[super viewDidLoad];
	self.title = @"History";
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}
- (void)didReceiveMemoryWarning{
	[super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar at_setBackgroundColor:[UIColor blueColor]];
	[self.navigationController.navigationBar at_setBottomLineColor:[UIColor redColor]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
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
	CATChildViewController *nvc = [[CATChildViewController alloc] init];
	[self.navigationController pushViewController:nvc animated:YES];
}

@end
