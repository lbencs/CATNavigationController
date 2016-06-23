//
//  CATWrapViewController.h
//  Pods
//
//  Created by lben on 6/16/16.
//
//

#import <UIKit/UIKit.h>

@interface CATWrapNavigationController : UINavigationController

@end

@interface CATWrapViewController : UIViewController
@property (nonatomic, strong, readonly) __kindof UIViewController *contentViewController;
+ (CATWrapViewController *)wrapWithViewController:(UIViewController *)viewController;
@end
