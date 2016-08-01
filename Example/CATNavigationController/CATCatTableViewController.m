//
//  CATCatTableViewController.m
//  CATNavigationController
//
//  Created by lben on 6/15/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

#import "CATCatTableViewController.h"
#import "CATNavigationController.h"
#import "CATDogChildViewController.h"

@interface CATCatTableViewController ()

@end

@implementation CATCatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
	self.title = @"Search";
	self.at_hiddenNavigationBar = YES;
	self.at_showTabBar = YES;
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
//    [self addCover];
}
- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
}
//- (void)addCover
//{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        CATDogChildViewController *vc = [[CATDogChildViewController alloc] init];
//        vc.at_showTabBar = YES;
//        [self addChildViewController:vc];
//        CGRect frame = self.view.bounds;
//        frame.origin.y = 100;
//        frame.size.height -= 200;
//        vc.view.frame = frame;
//        [self.view addSubview:vc.view];
//    });
//}
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
	cell.textLabel.text = [NSString stringWithFormat:@"%@",indexPath.description];
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"%@",self.navigationController);
	UIViewController *nvc = [[UIViewController alloc] init];
	nvc.view.backgroundColor = [UIColor whiteColor];
	[self.navigationController at_pushViewController:nvc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
