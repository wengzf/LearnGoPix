//
//  FSEasing.h
//  iDraw
//
//  Created by 翁志方 on 2016/12/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <Foundation/Foundation.h>


// t = currentTime
// b = beginning
// c = change
// d = duration

float easeOutQuint(float t, float b, float c, float d);

float easeInQuint(float t, float b, float c, float d);

float easeOutBack(float t, float b, float c, float d);

float easeOutBounce(float t, float b, float c, float d);


float clip(float st, float ed, float val);
