//
//  UINavigationBar+CATCustom.m
//  Pods
//
//  Created by lben on 6/15/16.
//
//

#import "UINavigationBar+CATCustom.h"
#import <objc/runtime.h>

extern NSInteger const kCATCustomExcludeAlphaTag = 999012;

static char CATCustomMaskLayerKey;
static char CATCustomBackgroundImageKey;
static char CATCustomEmptyImageKey;

@interface UINavigationBar ()
@property (nonatomic, strong, setter=_setMaskLayer:) UIView *_maskLayer;
@property (nonatomic, strong, setter=_setBackgroundImage:) UIImage *_backgroundImage;
@end

@implementation UINavigationBar (CATCustom)

- (void)at_setBackgroundColor:(UIColor *)backgroundColor{
	self._maskLayer.backgroundColor = backgroundColor;
}
- (void)at_setContentAlpha:(CGFloat)alpha{
	
	if (alpha < 0) alpha = 0;
	if (alpha > 1) alpha = 1;
	
	[self _setAlpha:alpha forSubviewsOfView:self];
}
- (void)at_undo{
	[self setBackgroundImage:self._backgroundImage forBarMetrics:UIBarMetricsDefault];
	[self._maskLayer removeFromSuperview];
	self._maskLayer = nil;
	self._backgroundImage = nil;
}


- (void)at_setBottomLineAlpha:(CGFloat)alpha{
}
- (void)at_setBottomLineColor:(UIColor *)color{
}

#pragma mark - privates methods

- (void)_setAlpha:(CGFloat)alpha forSubviewsOfView:(UIView *)view{
	
	for (UIView *v in view.subviews) {
		
		if (v == self._maskLayer) {
			continue;
		}else if ([v isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]){
			continue;
		}else if (v.tag == kCATCustomExcludeAlphaTag){
			continue;
		}
		
		v.alpha = alpha;
		
		[self _setAlpha:alpha forSubviewsOfView:view];
	}
}

#pragma mark - setter/getter

- (UIView *)_maskLayer{
	UIView *layer = objc_getAssociatedObject(self, &CATCustomMaskLayerKey);
	if (!layer) {
		self._backgroundImage = [self backgroundImageForBarMetrics:UIBarMetricsDefault];
		[self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
		
		layer = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(self.bounds) + 20)];
		layer.userInteractionEnabled = NO;
		layer.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		[self insertSubview:layer atIndex:0];
		[self _setMaskLayer:layer];
	}
	return layer;
}
- (void)_setMaskLayer:(UIView *)maskLayer{
	objc_setAssociatedObject(self, &CATCustomMaskLayerKey, maskLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIImage *)_backgroundImage{
	return objc_getAssociatedObject(self, &CATCustomBackgroundImageKey);
}
- (void)_setBackgroundImage:(UIImage *)_backgroundImage{
	return objc_setAssociatedObject(self, &CATCustomBackgroundImageKey, _backgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
