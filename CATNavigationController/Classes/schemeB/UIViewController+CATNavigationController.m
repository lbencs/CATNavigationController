//
//  UIViewController+CATNavigationController.m
//  Pods
//
//  Created by lben on 6/17/16.
//
//

#import "UIViewController+CATNavigationController.h"
#import <objc/runtime.h>

@implementation UIViewController (CATNavigationController)

- (void)at_setHiddenNavigationBar:(BOOL)at_hiddenNavigationBar{
    objc_setAssociatedObject(self, @selector(at_hiddenNavigationBar), @(at_hiddenNavigationBar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)at_hiddenNavigationBar{
   return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (BOOL)at_showTabBar{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)at_setShowTabBar:(BOOL)at_showTabBar{
    objc_setAssociatedObject(self, @selector(at_showTabBar), @(at_showTabBar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
