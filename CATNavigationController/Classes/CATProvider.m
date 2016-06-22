//
//  CATProvider.m
//  Pods
//
//  Created by lben on 6/17/16.
//
//

#import "CATProvider.h"
#import <objc/runtime.h>

@implementation CATProvider

@end



CATSwizzeMethod(Class aClass,SEL originalSelector, SEL swizzledSelector){
	
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
	}else{
		method_exchangeImplementations(originalMethod, swizzledMethod);
	}
}
@interface CATPageManager ()
@property (nonatomic, strong) NSMutableArray *pages;
@end

@implementation CATPageManager

+ (CATPageManager *)shareManager{
	static dispatch_once_t onceToken;
	static CATPageManager *manager = nil;
	dispatch_once(&onceToken, ^{
		manager = [[CATPageManager alloc] init];
	});
	return manager;
}

- (void)push:(UIImage *)objc{
	if (objc) {
		[self.pages addObject:objc];
	}
    NSLog(@"Push:%@",self.pages);
}
- (UIImage *)firstObjc{
	return [self.pages lastObject];
}
- (UIImage *)pop{
	UIImage *img = [self.pages lastObject];
	if (img) {
		[self.pages removeObject:img];
	}
    NSLog(@"Pop: %@",self.pages);
	return img;
}

#pragma mark -

- (NSMutableArray *)pages{
	if (!_pages) {
		_pages = [[NSMutableArray alloc] init];
	}
	return _pages;
}
@end

@implementation UIImage (CATExtension)

+ (UIImage *)at_imageWithColor:(UIColor *)color withSize:(CGSize)size{
	CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

+ (UIImage *)at_screenShotImageWithCaptureView:(UIView *)captureView{
	UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, NO, [UIScreen mainScreen].scale);
	[captureView drawViewHierarchyInRect:captureView.bounds afterScreenUpdates:YES];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

@end

CATSubViewSetAlpha(CGFloat alpha, UIView *superView){
	for (UIView *v in superView.subviews) {
		v.alpha = alpha;
		CATSubViewSetAlpha(alpha, v);
	}
}

@implementation UINavigationBar (CAT)
- (void)at_setAlpha:(CGFloat)alpha{
	CATSubViewSetAlpha(alpha, self);
}
@end
@implementation UITabBar (CAT)
- (void)at_setAlpha:(CGFloat)alpha{
	CATSubViewSetAlpha(alpha, self);
}

@end