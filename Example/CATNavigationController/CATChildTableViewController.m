//
//  CATChildTableViewController.m
//  CATNavigationController
//
//  Created by lben on 8/2/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

#import "CATChildTableViewController.h"
#import "CATChildViewController.h"
#import "CATNavigationController.h"


@interface CATChildTableViewController ()

@end


@implementation CATChildTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.at_showTabBar = YES;
    self.at_navigationBarBackgroundColor = [UIColor yellowColor];
    self.at_navigationBarBottomLineColor = [UIColor redColor];
    //	self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", self.navigationController);
    CATChildViewController *nvc = [[CATChildViewController alloc] init];
    [self.navigationController pushViewController:nvc animated:YES];
}

@end
