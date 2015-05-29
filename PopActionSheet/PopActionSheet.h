//
//  PopActionSheet.h
//
//  Created by Lvjianfeng on 15/5/27.
//  Copyright (c) 2015年 CoderJianfeng. All rights reserved.
//
//  代码在原作者扩展,原作者GitHub链接 GitHub: http://github.com/LeoiOS
//

#import <UIKit/UIKit.h>

@class PopActionSheet;

@protocol PopActionSheetDelegate <NSObject>

@optional

/**
 *  点击了buttonIndex处的按钮
 */
- (void)actionSheet:(PopActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface PopActionSheet : UIView

/**
 *  返回一个ActionSheet对象, 实例方法
 *
 *  @param title 提示标题
 *
 *  @param titles 所有按钮的标题
 *
 *  @param redButtonIndex 红色按钮的index
 *
 *  @param bounds 总大小
 *
 *  @param buttonHeight 点击的button的高度
 *
 *  @param actionSheetColor 弹出窗的背景颜色
 *
 *  @param titleColor 标题字体的颜色
 *
 *  @param cancelColor 取消按钮的字体颜色
 *
 *  @param cancelBackgoundColor 取消按钮的背景颜色
 *
 *  @param delegate 代理
 *
 *  Tip: 如果没有红色按钮, redButtonIndex给`-1`即可
 */
+ (instancetype)popSheetWithTitle:(NSString *)title
                  buttonTitles:(NSArray *)titles
                redButtonIndex:(NSInteger)buttonIndex
                      delegate:(id<PopActionSheetDelegate>)delegate;

+ (instancetype)popSheetWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
               redButtonIndex:(NSInteger)buttonIndex
                       bounds:(CGSize)bounds
                 buttonHeight:(CGFloat)height
             actionSheetColor:(UIColor *)actionSheetColor
                   titleColor:(UIColor *)titleColor
                  cancelColor:(UIColor *)cancelTextColor
         cancelBackgoundColor:(UIColor *)cancelBackgoundColor
                     delegate:(id<PopActionSheetDelegate>)delegate;

/**
 *  返回一个ActionSheet对象, 实例方法
 *
 *  @param title 提示标题
 *
 *  @param titles 所有按钮的标题
 *
 *  @param redButtonIndex 红色按钮的index
 *
 *  @param bounds 总大小
 *
 *  @param buttonHeight 点击的button的高度
 *
 *  @param actionSheetColor 弹出窗的背景颜色
 *
 *  @param titleColor 标题字体的颜色
 *
 *  @param cancelColor 取消按钮的字体颜色
 *
 *  @param cancelBackgoundColor 取消按钮的背景颜色
 *
 *  @param delegate 代理
 *
 *  Tip: 如果没有红色按钮, redButtonIndex给`-1`即可
 */
- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
               redButtonIndex:(NSInteger)buttonIndex
                     delegate:(id<PopActionSheetDelegate>)delegate;

- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
               redButtonIndex:(NSInteger)buttonIndex
                       bounds:(CGSize)bounds
                 buttonHeight:(CGFloat)height
             actionSheetColor:(UIColor *)actionSheetColor
                   titleColor:(UIColor *)titleColor
                  cancelColor:(UIColor *)cancelTextColor
         cancelBackgoundColor:(UIColor *)cancelBackgoundColor
                     delegate:(id<PopActionSheetDelegate>)delegate;

/**
 *  弹出ActionSheet
 *
 *  @param duration 动画弹出速度
 *
 *  @param options 动画模式
 *
 *  Tip: 默认动画向上弹出  动画0.2f
 */
- (void)show;

- (void)show:(NSTimeInterval)duration;

- (void)show:(NSTimeInterval)duration options:(UIViewAnimationOptions)option;
@end
