//
//  CATTransitionAnimation.m
//  Pods
//
//  Created by lbencs on 6/19/16.
//
//

#import "CATTransitionAnimation.h"

@implementation CATTransitionAnimation

- (instancetype)initWithCompletion:(void (^)())completionHandler{
    if (self = [super init]) {
        _completionHandler = completionHandler;
    }
    return self;
}
- (instancetype)initWithBegin:(void (^)(id<UIViewControllerContextTransitioning> transitionContext))beginHandler completion:(void (^)())completionHandler{
    if (self = [super init]) {
        _completionHandler = completionHandler;
        _beginHandler = beginHandler;
    }
    return self;
}

#pragma mark - 

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (self.beginHandler) {
        self.beginHandler(transitionContext);
    }
}

- (void)animationEnded:(BOOL)transitionCompleted{
    if (self.completionHandler) {
        self.completionHandler();
    }
}

@end
