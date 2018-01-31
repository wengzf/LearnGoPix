//
//  ViewController.m
//  音乐相册Demo
//
//  Created by 翁志方 on 2018/1/31.
//  Copyright © 2018年 wzf. All rights reserved.
//

#import "ViewController.h"
#import "FSEasing.h"
#import "UIImage+Extension.h"

@interface ViewController ()
{
    NSInteger totalNum;
    NSInteger halfNum;
    
    NSMutableArray *imgArr;
    
    UIView *contentView;
    UIView *grayContentView;
    UIImageView *imgView;
    UIImageView *grayImgView;
    
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGFloat halfScreenWidth;
    CGFloat halfScreenHeight;
    CGFloat imgWidth;
    CGFloat imgHeight;
    
    CGFloat scaleFactor;
    CGFloat maxScaleFactor;
    CGFloat originalScaleFactor;
    CGFloat minScaleFactor;
    
    NSTimer *timer;
    
    UITapGestureRecognizer *tap;
    
    NSInteger curFrame;     // 当前在第几帧
    NSInteger totalFrame;   // 根据图片数量决定
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 先实现两张图片的切换效果
    // 1. 原图慢慢缩小，保持顶部不变
    // 2. 灰度化图片从底部向上移动
    // 3. 右下角向左上角裁剪
    
    [self imageInit];
    [self.view bringSubviewToFront:self.slider];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}
- (void)imageInit
{
    totalNum = 6;       // 保证被2整除
    halfNum = 3;
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    halfScreenWidth = screenWidth/2;
    halfScreenHeight = screenHeight/2;
    
    maxScaleFactor = 1.4;
    originalScaleFactor = 1.2;
    minScaleFactor = 1;
    scaleFactor = 1.25;
    
    imgWidth = 500;
    imgHeight = 300;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.JPG",(long)1]];
    UIImage *grayImg = [img grayImage:img];
    
    // 添加彩色图片
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -screenHeight/2, screenWidth, screenHeight)];
    imgView.image = img;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.layer.anchorPoint = CGPointMake(0.5, 0);
    imgView.transform = CGAffineTransformMakeScale(maxScaleFactor, maxScaleFactor);
    imgView.clipsToBounds = YES;
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [contentView addSubview:imgView];
    [self.view addSubview:contentView];
    
    // 灰度化图片
    grayImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, -screenHeight/2, screenHeight)];
    grayImgView.image = img;
    grayImgView.contentMode = UIViewContentModeScaleAspectFill;
    grayImgView.layer.anchorPoint = CGPointMake(0.5, 0);
    grayImgView.clipsToBounds = YES;
    
    grayContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [grayContentView addSubview:grayImgView];
    [self.view addSubview:grayContentView];
    
    [self.view bringSubviewToFront:contentView];
}
- (void)tap
{
    if (timer == nil) {
        self.slider.value = 0;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.0333 target:self selector:@selector(timerBlock) userInfo:nil repeats:YES];
    }
}
- (void)timerBlock
{
    // 30帧为一秒钟
    ++curFrame;
    if (curFrame > totalNum) {
        [timer invalidate];
        timer = nil;
    }
    [self displayCurrentFrame];
    
//    self.slider.value += 0.005;
//    [self sliderValueChanged:self.slider];
    
}
- (void)displayCurrentFrame
{
    CGFloat value = curFrame / 150.0;
    // 图片向上缩小
    {
        CGFloat scale = maxScaleFactor-(maxScaleFactor-originalScaleFactor)*value;
        imgView.transform =  CGAffineTransformMakeScale(scale, scale);
    }
    // 灰度图片放大
    {
        CGFloat scale = minScaleFactor+(originalScaleFactor-minScaleFactor)*value;
        grayImgView.transform =  CGAffineTransformMakeScale(scale, scale);
    }
    
    // 计算当前
    CGPoint topLeft = CGPointMake(0, 0);
    CGPoint topRight = CGPointMake(screenWidth, 0);
    CGPoint bottomLeft = CGPointMake(0, screenHeight);
    CGPoint bottomRight = CGPointMake(screenWidth, screenHeight);
    
    // 手动计算运动到了哪个角度
    CGPoint stPoint;
    CGPoint edPoint;
    
    // 提供数组和每个点的时间函数，
    
    // 一秒30帧
    if (value>0.25) {
        // 灰色部分裁剪
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(screenWidth, screenHeight)];
        
        // stPoint 从右下角到左下角
        
        // stPoint 从左下角到 左边中点
        
        // stPoint 从左边中点 到 左上角
        
        // stPoint 从左上角 到 上边3分之一处
        
        
        
        
        
        CAShapeLayer *mask = [CAShapeLayer layer];
        mask.frame = contentView.bounds;
        mask.path = [bezierPath CGPath];
        
        grayContentView.layer.mask = mask;
        
        //        // 彩色图片裁剪
        //        CGMutablePathRef path = CGPathCreateMutable();
        //
        //        CAShapeLayer *mask = [CAShapeLayer layer];
        //        mask.frame = contentView.bounds;
        //        mask.path = path;
        //
        //        contentView.layer.mask = mask;
        
    }
}


- (IBAction)sliderValueChanged:(UISlider *)sender
{
}





@end
