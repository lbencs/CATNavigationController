//
//  UIImage+CATOO.m
//  Pods
//
//  Created by lben on 6/16/16.
//
//

#import "UIImage+CATOO.h"

@implementation UIImage (CATOO)

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
@end
