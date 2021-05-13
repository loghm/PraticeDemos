//
//  ViewController.m
//  singleLineProject
//
//  Created by 黄明族 on 2021/5/12.
//

#import "ViewController.h"
#import "UIView+OnePixelBorder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self onePixelView];
}

- (void)onePixelView {
    CGFloat pixelScale = [UIScreen mainScreen].scale;
    // 当pixelScale为2的时候，其实不会出现1像素的问题。仅当奇数像素宽度的线在渲染的时候将会表现为柔和的宽度扩展到向上的整数宽度的线。为什么是奇数像素的线宽呢？
    // 我们拿non-retina屏幕来举例，我们要绘制一个1个点宽度的线，因为non-retina屏中，1个点等于1个像素。因为绘制是按照，比如(1.0, 1.0)到(1.0, 10.0)的位置进行绘制，这样一个点宽度就会处在两个像素的中间，横跨2个像素，因为反锯齿的算法作用下，宽度会像外进行扩散，颜色变浅，导致1个点(1像素)的宽度，被绘制成了2个像素。这个时候只要偏移1/[UIScreen mainScreen].scale/2个点，就可以落在一个完整的像素宽度内，也就不会触发反锯齿的算法。
    // 可以通过(int)(1 * pixelScale + 1) % 2 == 0来判断是否落在奇数单元中(也就是宽度在两个像素中间)
    // see also: https://www.jianshu.com/p/d9f5e0aabcdb
    // 官方文档：https://developer.apple.com/library/archive/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
    
    UIView* vw1 = [[UIView alloc] initWithFrame:CGRectMake(20.500000, 200.500000, 80.000000, 40.00000)];
    [vw1.layer setBorderColor:[UIColor greenColor].CGColor];
    [vw1.layer setBorderWidth:(1.0f/pixelScale)];
    
    UIView* vw2 = [[UIView alloc] initWithFrame:CGRectMake(20.500000, 300.500000, 80.000000, 40.00000)];
    [vw2.layer setBorderColor:[UIColor greenColor].CGColor];
    [vw2.layer setBorderWidth:(1.0f/pixelScale)];
    if ((int)(1 * pixelScale + 1) % 2 == 0) { // 落在了奇数单元
        [vw2 resizeForBorder];
    }
    
    [self.view addSubview:vw1];
    [self.view addSubview:vw2];
}


@end
