//
//  UINavigationBar+CATCustom.m
//  Pods
//
//  Created by lben on 6/15/16.
//
//

#import "UINavigationBar+CATCustom.h"
#import "CATProvider.h"
#import <objc/runtime.h>

extern NSInteger const kCATCustomExcludeAlphaTag = 999012;

static char CATCustomMaskLayerKey;
static char CATCustomBackgroundImageKey;
static char CATCustomEmptyImageKey;


@interface UINavigationBar ()
@property (nonatomic, strong, setter=_setMaskLayer:) UIView *_maskLayer;
//@property (nonatomic, strong, setter=_setBackgroundImage:) UIImage *_backgroundImage;
@end


@implementation UINavigationBar (CATCustom)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //        CATSwizzeMethod(self, @selector(setBackgroundImage:), @selector(at_setBackgroundImage:));
        //        CATSwizzeMethod(self, @selector(setBackgroundImage:forBarMetrics:), @selector(at_setBackgroundImage:forBarMetrics:));
        //        CATSwizzeMethod(self, @selector(setBackgroundImage:forBarPosition:barMetrics:), @selector(at_setBackgroundImage:forBarPosition:barMetrics:));
        CATSwizzeMethod(self, @selector(setTranslucent:), @selector(at_setTranslucent:));
    });
}
- (void)at_setTranslucent:(BOOL)translucent
{
    [self at_setTranslucent:translucent];
    [self _clearBackgroundColorAtView:self];
}
- (void)at_setBackgroundImage:(UIImage *)image
{
    [self at_setBackgroundImage:image];
}
- (void)at_setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics
{
    [self at_setBackgroundImage:backgroundImage forBarMetrics:barMetrics];
}

- (void)at_setBackgroundImage:(UIImage *)backgroundImage forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics
{
    [self at_setBackgroundImage:backgroundImage forBarPosition:barPosition barMetrics:barMetrics];
}


- (void)at_setBackgroundColor:(UIColor *)backgroundColor
{
    //	self.translucent = YES;
    self._maskLayer.backgroundColor = backgroundColor;
}
- (void)at_setContentAlpha:(CGFloat)alpha
{
    alpha = MIN(MAX(0, alpha), 1);
    [self _setAlpha:alpha forSubviewsOfView:self];
}
- (void)at_undo
{
    [self at_setAlpha:1.0f];
}
- (void)at_setBottomLineColor:(UIColor *)color
{
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    UIImage *line = [UIImage at_imageWithColor:color withSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 0.3)];
    [self at_setBottomLineImage:line];
}
- (void)at_setBottomLineImage:(UIImage *)image
{
    [self setShadowImage:[UIImage new]];
    [self setShadowImage:image];
}

#pragma mark - privates methods
- (void)_setAlpha:(CGFloat)alpha forSubviewsOfView:(UIView *)view
{
    for (UIView *v in view.subviews) {
        if (v == self._maskLayer) {
            continue;
        } else if ([v isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
            continue;
        } else if (v.tag == kCATCustomExcludeAlphaTag) {
            continue;
        }

        v.alpha = alpha;

        [self _setAlpha:alpha forSubviewsOfView:v];
    }
}
- (void)_clearBackgroundColorAtView:(UIView *)view
{
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            v.backgroundColor = [UIColor clearColor];
            return;
        } else {
            [self _clearBackgroundColorAtView:v];
        }
    }
}

#pragma mark - setter/getter
- (UIView *)_maskLayer
{
    UIView *layer = objc_getAssociatedObject(self, _cmd);

    [self _clearBackgroundColorAtView:self];

    if (!layer) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        layer = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(self.bounds) + 20)];
        layer.userInteractionEnabled = NO;
        layer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self insertSubview:layer atIndex:0];
        [self _setMaskLayer:layer];
    }
    return layer;
}
- (void)_setMaskLayer:(UIView *)maskLayer
{
    objc_setAssociatedObject(self, @selector(_maskLayer), maskLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
