//
//  UINavigationBar+CATCustom.h
//  Pods
//
//  Created by lben on 6/15/16.
//
//

#import <UIKit/UIKit.h>

OBJC_EXTERN NSInteger const kCATCustomExcludeAlphaTag;

@interface UINavigationBar (CATCustom)
- (void)at_setBackgroundColor:(UIColor *)backgroundColor;
- (void)at_setBottomLineColor:(UIColor *)color;
- (void)at_setContentAlpha:(CGFloat)alpha;
- (void)at_undo;
@end
