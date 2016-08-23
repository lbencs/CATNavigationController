//
//  CATTransitionAnimation.h
//  Pods
//
//  Created by lbencs on 6/19/16.
//
//

#import <Foundation/Foundation.h>

@interface CATTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) UINavigationController *navigationController; /**< <#annotation#> */

@property (nonatomic, copy) void(^completionHandler)();
@property (nonatomic, copy) void(^beginHandler)(id<UIViewControllerContextTransitioning> transitionContext);

- (instancetype)initWithCompletion:(void(^)())completionHandler;
- (instancetype)initWithBegin:(void(^)(id<UIViewControllerContextTransitioning>transitionContext))beginHandler completion:(void(^)())completionHandler;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext NS_REQUIRES_SUPER;
- (void)animationEnded:(BOOL)transitionCompleted NS_REQUIRES_SUPER;

@end
