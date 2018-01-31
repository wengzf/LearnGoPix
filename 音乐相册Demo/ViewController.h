//
//  ViewController.h
//  音乐相册Demo
//
//  Created by 翁志方 on 2018/1/31.
//  Copyright © 2018年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *slider;

- (IBAction)sliderValueChanged:(UISlider *)sender;

@end

