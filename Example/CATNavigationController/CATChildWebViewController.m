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
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    self.webView = webView;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self.webView loadRequest:request];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
