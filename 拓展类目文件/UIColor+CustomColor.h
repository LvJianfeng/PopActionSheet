//
//  UIColor+CustomColor.h
//  JFPersonPage
//
//  Created by LvJianfeng on 15/5/31.
//  Copyright (c) 2015年 CoderJianfeng. All rights reserved.
//
//  https://github.com/LvJianfeng
//  http://weibo.com/aaalizzwell
#import <UIKit/UIKit.h>

@interface UIColor (CustomColor)
/*
 * Put the string color into UIColor, #5F9C74, for example
 * Param stringToConvert #5F9C74
 */
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

/*
 * Simplify the original method
 */
+ (UIColor *)colorWithRed:(NSUInteger)red
                    green:(NSUInteger)green
                     blue:(NSUInteger)blue;


/*
 * Custom Color
 */
+ (UIColor *)customGrayColor;
+ (UIColor *)customRedColor;
+ (UIColor *)customYellowColor;
+ (UIColor *)customGreenColor;
+ (UIColor *)customBlueColor;

/*
 * Global or System Color
 */
+ (UIColor *)customSysGreenColor;
@end
