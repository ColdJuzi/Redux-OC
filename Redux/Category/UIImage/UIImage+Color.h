//
//  UIImage+Color.h
//  PhantomSteward
//
//  Created by LiangHao on 02/12/2016.
//  Copyright © 2016 PhantomSmart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

///  根据图片名称加载UIImage
+ (UIImage *)imageWithColor:(UIColor *)color;

///  根据图片名称加载UIImage,需要设置UIImage的Size
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//loseless resize
- (UIImage *)imageResizedToScale:(CGFloat)scale;

- (UIImage *)imageScaledToWidth:(CGFloat)width height:(CGFloat)height;

- (UIImage *)imageScaledToQuarter;
- (UIImage *)imageScaledToHalf;
- (UIImage *)imageScaledToScale:(CGFloat)scale;
- (UIImage *)imageScaledToScale:(CGFloat)scale
       withInterpolationQuality:(CGInterpolationQuality)quality;

//  gray
- (UIImage *)imageWithGrayDegree;

@end

@interface UIImage (FixOrientation)

- (UIImage *)fixOrientation;

@end
