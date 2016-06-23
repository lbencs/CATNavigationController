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
CATSubViewSetAlpha(CGFloat alpha, UIView *superView){
	for (UIView *v in superView.subviews) {
		v.alpha = alpha;
		CATSubViewSetAlpha(alpha, v);
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
	UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
	UILabel *label = [keyWindow viewWithTag:10010];
	if (!label) {
		label = [[UILabel alloc] initWithFrame:CGRectMake(0, 550, keyWindow.bounds.size.width, 44)];
		label.tag = 10010;
		[keyWindow addSubview:label];
	}
	label.text = [NSString stringWithFormat:@"ImageCache:%ld",(long)self.pages.count];
	
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
	
	UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
	UILabel *label = [keyWindow viewWithTag:10010];
	if (!label) {
		label = [[UILabel alloc] initWithFrame:CGRectMake(0, 550, keyWindow.bounds.size.width, 44)];
		label.tag = 10010;
		[keyWindow addSubview:label];
	}
	label.text = [NSString stringWithFormat:@"ImageCache:%ld",(long)self.pages.count];
	NSLog(@"Pop: %@",self.pages);
	return img;
}
- (NSInteger)count{
	return [self.pages count];
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