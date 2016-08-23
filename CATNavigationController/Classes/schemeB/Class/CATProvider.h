//
//  CATProvider.h
//  Pods
//
//  Created by lben on 6/17/16.
//
//

#import <Foundation/Foundation.h>

@interface CATProvider : NSObject
@end

typedef NS_ENUM(NSInteger, CATNavigationPopAnimation) {
    CATNavigationPopAnimationPop,           //Pop 方式
    CATNavigationPopAnimationDrag,          //拖拽方式
    CATNavigationPopAnimationDragCalcelled, //拖拽取消
    CATNavigationPopAnimationDragFinished   //拖拽Pop完成
};

CATSwizzeMethod(Class aClass,SEL originalSelector, SEL swizzledSelector);

@interface CATPageManager : NSObject
+ (CATPageManager *)shareManager;

@property (nonatomic, assign) CATNavigationPopAnimation *animationStatus;

//- (void)push:(UIImage *)objc;
//- (UIImage *)pop;
//
//- (UIImage *)firstObjc;
//- (NSInteger)count;

@property (nonatomic, strong) UIImage *cache;
@end


@interface UIImage (CATExtension)
+ (UIImage *)at_imageWithColor:(UIColor *)color withSize:(CGSize)size;
+ (UIImage *)at_screenShotImageWithCaptureView:(UIView *)captureView;
@end

@interface UINavigationBar (CAT)
- (void)at_setAlpha:(CGFloat)alpha;
@end

@interface UITabBar (CAT)
- (void)at_setAlpha:(CGFloat)alpha;
@end

@interface UINavigationController (CAT)
- (void)at_push:(UIImage *)objc;
- (UIImage *)at_pop;

- (UIImage *)at_firstObjc;
- (NSInteger)at_count;
@end

