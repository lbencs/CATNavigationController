//
//  CATProvider.m
//  Pods
//
//  Created by lben on 6/17/16.
//
//

#import "CATProvider.h"
#import <objc/runtime.h>
#import <mach/mach.h>


@implementation CATProvider
@end

vm_size_t CATReportUsedMemory()
{
    /*
	 To get the actual bytes of memory that your application is using, you can do something like the example below. However, you really should become familiar with the various profiling tools as well as they are designed to give you a much better picture of usage over-all.
	 There is also a field in the structure info.virtual_size which will give you the number of bytes available virtual memory (or memory allocated to your application as potential virtual memory in any event). The code that pgb links to will give you the amount of memory available to the device and what type of memory it is.
	 */
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t keer = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    if (keer == KERN_SUCCESS) {
        NSLog(@"Memory in use (in bytes): %u", info.resident_size);
        return info.resident_size;
    } else {
        NSLog(@"Error with task_info() %s", mach_error_string(keer));
    }
    return 0;
}
void CATReportFreeMemmory()
{
}
void CATReportMethodStock()
{
#if DEBUG
    NSLog(@"%@", [NSThread callStackSymbols]);
#endif
}

CATSwizzeMethod(Class aClass, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
    BOOL didAddMethod = class_addMethod(aClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(aClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
void CATSubViewSetAlpha(CGFloat alpha, UIView *superView)
{
    for (UIView *v in superView.subviews) {
        v.alpha = alpha;
        CATSubViewSetAlpha(alpha, v);
    }
}


@interface CATPageManager ()
@property (nonatomic, strong) NSMutableArray *pages;
@end


@implementation CATPageManager

+ (CATPageManager *)shareManager
{
    static dispatch_once_t onceToken;
    static CATPageManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[CATPageManager alloc] init];
    });
    return manager;
}
- (void)push:(UIImage *)objc
{
    if (objc) {
        [self.pages addObject:objc];
    }
#if DEBUG
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UILabel *label = [keyWindow viewWithTag:501934];
    if (!label || ![label isKindOfClass:[UILabel class]]) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, keyWindow.bounds.size.width, 44)];
        label.tag = 501934;
        [keyWindow addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"ImageCache:%ld", (long)self.pages.count];

    NSLog(@"Push:%@", self.pages);
#endif
}
- (UIImage *)firstObjc
{
    return [self.pages lastObject];
}
- (UIImage *)pop
{
    UIImage *img = [self.pages lastObject];
    if (img) {
        [self.pages removeObject:img];
    }
#if DEBUG
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UILabel *label = [keyWindow viewWithTag:501934];
    if (!label || ![label isKindOfClass:[UILabel class]]) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, keyWindow.bounds.size.width, 44)];
        label.tag = 501934;
        [keyWindow addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"ImageCache:%ld", (long)self.pages.count];
    NSLog(@"Pop: %@ ", self.pages);
#endif
    return img;
}
- (NSInteger)count
{
    return [self.pages count];
}

#pragma mark -
- (NSMutableArray *)pages
{
    if (!_pages) {
        _pages = [[NSMutableArray alloc] init];
    }
    return _pages;
}
@end


@implementation UIImage (CATExtension)
+ (UIImage *)at_imageWithColor:(UIColor *)color withSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)at_screenShotImageWithCaptureView:(UIView *)captureView
{
    UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, NO, [UIScreen mainScreen].scale);
    [captureView drawViewHierarchyInRect:captureView.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end


@implementation UINavigationBar (CAT)
- (void)at_setAlpha:(CGFloat)alpha
{
    CATSubViewSetAlpha(alpha, self);
}
@end


@implementation UITabBar (CAT)
- (void)at_setAlpha:(CGFloat)alpha
{
    CATSubViewSetAlpha(alpha, self);
}

@end
