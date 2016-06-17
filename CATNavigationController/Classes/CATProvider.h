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


@interface CATPageManager : NSObject
+ (CATPageManager *)shareManager;
- (void)push:(UIImage *)objc;
- (UIImage *)firstObjc;
- (UIImage *)pop;
@end


@interface UIImage (CATExtension)
+ (UIImage *)at_imageWithColor:(UIColor *)color withSize:(CGSize)size;
+ (UIImage *)at_screenShotImageWithCaptureView:(UIView *)captureView;
@end