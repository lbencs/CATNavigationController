//
//  CATChildWebViewController.m
//  CATNavigationController
//
//  Created by lben on 8/2/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

#import "CATChildWebViewController.h"


@interface CATChildWebViewController ()
@property (weak, nonatomic) UIWebView *webView;
@end


@implementation CATChildWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning
{
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
