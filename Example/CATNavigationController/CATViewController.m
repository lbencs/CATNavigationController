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
#import "CATChildTableViewController.h"
#import "CATChildWebViewController.h"
#import "CATChildCollectionViewController.h"
#import "CATChildHorizontalCollectionViewController.h"

#import "UINavigationBar+CATCustom.h"


@interface CATViewController () <UIScrollViewDelegate>
@end


@implementation CATViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"History";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.at_showTabBar = YES;
    self.at_navigationBarBackgroundColor = [UIColor yellowColor];
    self.at_navigationBarBottomLineColor = [UIColor redColor];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Push to UITableViewController.";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Push To UIWebViewController";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"Push To UICollectionViewController";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"Push To HorizontalCollectionViewController";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = nil;
    if (indexPath.row == 0) {
        vc = [[CATChildTableViewController alloc] init];
    } else if (indexPath.row == 1) {
        vc = [[CATChildWebViewController alloc] init];
    }else if (indexPath.row == 2){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        vc = [[CATChildCollectionViewController alloc] initWithCollectionViewLayout:layout];
    }else if (indexPath.row == 3){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        vc = [[CATChildHorizontalCollectionViewController alloc] initWithCollectionViewLayout:layout];
    } else {
         vc = [[CATChildViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}
@end
