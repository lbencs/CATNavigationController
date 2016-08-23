//
//  CATChildNaviAlphaViewController.m
//  CATNavigationController
//
//  Created by lben on 8/22/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

#import "CATChildNaviAlphaViewController.h"
#import "UINavigationBar+CATCustom.h"

@interface CATChildNaviAlphaViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation CATChildNaviAlphaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	scrollView.contentSize = CGSizeMake(self.view.bounds.size.width,self.view.bounds.size.height + 500);
	scrollView.backgroundColor = [UIColor whiteColor];
	scrollView.delegate = self;
	[self.view addSubview:scrollView];
	_scrollView = scrollView;
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"9cffc8fd0110d787faac199d3dc85830"]];
	imageV.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
	imageV.layer.borderColor = [UIColor blackColor].CGColor;
	imageV.layer.borderWidth = 2.0f;
	[_scrollView addSubview:imageV];
	_imageView = imageV;
	
	imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"9cffc8fd0110d787faac199d3dc85830"]];
	imageV.frame = CGRectMake(50, 350, self.view.bounds.size.width, 200);
	[_scrollView addSubview:imageV];
	
	imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"9cffc8fd0110d787faac199d3dc85830"]];
	imageV.frame = CGRectMake(50, 550, self.view.bounds.size.width, 200);
	[_scrollView addSubview:imageV];
	
	imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"9cffc8fd0110d787faac199d3dc85830"]];
	imageV.frame = CGRectMake(50, 750, self.view.bounds.size.width, 200);
	[_scrollView addSubview:imageV];
	
	
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar at_setContentAlpha:0.0];
}
- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	self.title = @"导航栏透明";
	[self.navigationController.navigationBar at_setContentAlpha:0.0];
}
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.navigationController.navigationBar at_undo];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat alpha = scrollView.contentOffset.y / 200 * 2.0;
	[self.navigationController.navigationBar at_setContentAlpha:alpha];
	
	CGFloat offset = -scrollView.contentOffset.y;
//	NSLog(@"%f",offset);
	if (offset >= 0) {
		CGRect frame = _imageView.frame;
		CGFloat rate = (200 + offset) / frame.size.height;
		frame.size.height = 200 + offset;
		frame.size.width = frame.size.width * rate;
		frame.origin.x = -(frame.size.width - self.view.bounds.size.width) / 2.0;
		frame.origin.y = -offset;
		_imageView.frame = frame;
	}
	NSLog(@"%@",NSStringFromCGRect(_imageView.frame));
}


@end
