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


CATSwizzeMethod(Class aClass,SEL originalSelector, SEL swizzledSelector);

@interface CATPageManager : NSObject
+ (CATPageManager *)shareManager;

- (void)push:(UIImage *)objc;
- (UIImage *)pop;

- (UIImage *)firstObjc;
- (NSInteger)count;

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
