//
//  CATCustomChildViewController.m
//  CATNavigationController
//
//  Created by lbencs on 8/2/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

#import "CATCustomChildViewController.h"

@interface CATCustomChildViewController ()

@end

@implementation CATCustomChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 69, 300, 200)];
    imageView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 273, 300, 200)];
    label.text = @"==============\n=======================================================================================";
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(btnClick:)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnClick:(id)sender
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
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
