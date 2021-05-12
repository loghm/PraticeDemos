//
//  UIView+OnePixelBorder.m
//  singleLineProject
//
//  Created by 黄明族 on 2021/5/12.
//

#import "UIView+OnePixelBorder.h"

@implementation UIView (OnePixelBorder)

-(void)resizeForBorder
{
    self.frame = [self getResizeRect:self.frame];
}

-(CGRect)getResizeRect:(CGRect)rect
{
    CGFloat pixelScale = [UIScreen mainScreen].scale;

    CGFloat top = CGRectGetMinY(rect) * pixelScale;
    CGFloat left = CGRectGetMinX(rect) * pixelScale;
    CGFloat right = CGRectGetMaxX(rect) * pixelScale;
    CGFloat bottom = CGRectGetMaxY(rect) * pixelScale;

    //保证像素点为整数
    CGFloat re_top = (CGFloat)[self getIntValue:top];
    CGFloat re_left = (CGFloat)[self getIntValue:left];
    CGFloat re_right = (CGFloat)[self getIntValue:right];
    CGFloat re_bottom = (CGFloat)[self getIntValue:bottom];

    //通过像素点获取坐标
    return CGRectMake(re_left/pixelScale, re_top/pixelScale, (re_right-re_left)/pixelScale,(re_bottom-re_top)/pixelScale);
}

-(NSInteger)getIntValue:(CGFloat)value
{//获取最接近整数
//    CGFloat floatValue = value - (NSInteger)value;
//    if(floatValue<0.5)
//    {
//        return (NSInteger)value;
//    }
//    else
//    {
//        return ((NSInteger)value)+1;
//    }
    return ceil(value);
}

@end
