//
//  PopActionSheet.m
//
//  Created by Lvjianfeng on 15/5/27.
//  Copyright (c) 2015年 CoderJianfeng. All rights reserved.
//
//  代码在原作者扩展,原作者GitHub链接 GitHub: http://github.com/LeoiOS
//

#import "PopActionSheet.h"

// 按钮高度
#define BUTTON_H 49.0f
// 屏幕尺寸
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
// 颜色
#define LCColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

@interface PopActionSheet () {
    
    /** 所有按钮 */
    NSArray *_buttonTitles;
    
    /** 暗黑色的view */
    UIView *_darkView;
    
    /** 所有按钮的底部view */
    UIView *_bottomView;
    
    /** 代理 */
    id<PopActionSheetDelegate> _delegate;
}

@property (nonatomic, strong) UIWindow *backWindow;
@end

@implementation PopActionSheet

#pragma mark +methods
+ (instancetype)popSheetWithTitle:(NSString *)title
                     buttonTitles:(NSArray *)titles
                   redButtonIndex:(NSInteger)buttonIndex
                         delegate:(id<PopActionSheetDelegate>)delegate
{
    return [[self alloc] initWithTitle:title buttonTitles:titles redButtonIndex:buttonIndex delegate:delegate];
}

+ (instancetype)popSheetWithTitle:(NSString *)title
                     buttonTitles:(NSArray *)titles
                   redButtonIndex:(NSInteger)buttonIndex
                           bounds:(CGSize)bounds
                     buttonHeight:(CGFloat)height
                 actionSheetColor:(UIColor *)actionSheetColor
                       titleColor:(UIColor *)titleColor
                      cancelColor:(UIColor *)cancelTextColor
             cancelBackgoundColor:(UIColor *)cancelBackgoundColor
                         delegate:(id<PopActionSheetDelegate>)delegate
{
    return [[self alloc] initWithTitle:title buttonTitles:titles redButtonIndex:buttonIndex bounds:bounds buttonHeight:height actionSheetColor:actionSheetColor titleColor:titleColor cancelColor:cancelTextColor cancelBackgoundColor:cancelBackgoundColor delegate:delegate];
}

#pragma mark -methods
- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
               redButtonIndex:(NSInteger)buttonIndex
                     delegate:(id<PopActionSheetDelegate>)delegate {
    
    if (self = [super init]) {
        
        _delegate = delegate;
        
        // 暗黑色的view
        UIView *windowView = [[UIView alloc] init];
        [windowView setAlpha:0];
        [windowView setUserInteractionEnabled:NO];
        [windowView setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [windowView setBackgroundColor:LCColor(46, 49, 50)];
        [self addSubview:windowView];
        _darkView = windowView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [windowView addGestureRecognizer:tap];
        
        // 所有按钮的底部view
        UIView *bottomView = [[UIView alloc] init];
        [bottomView setBackgroundColor:LCColor(214, 214, 222)];
        [self addSubview:bottomView];
        _bottomView = bottomView;
        
        if (title) {
            
            // 标题
            UILabel *label = [[UILabel alloc] init];
            [label setText:title];
            [label setTextColor:LCColor(111, 111, 111)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:[UIFont systemFontOfSize:13.0f]];
            [label setBackgroundColor:[UIColor whiteColor]];
            [label setFrame:CGRectMake(0, 0, SCREEN_SIZE.width, BUTTON_H)];
            [bottomView addSubview:label];
        }
        
        if (titles.count) {
            
            _buttonTitles = titles;
            
            for (int i = 0; i < titles.count; i++) {
                
                // 所有按钮
                UIButton *btn = [[UIButton alloc] init];
                [btn setTag:i];
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn setTitle:titles[i] forState:UIControlStateNormal];
                [[btn titleLabel] setFont:[UIFont systemFontOfSize:16.0f]];
                
                UIColor *titleColor = nil;
                if (i == buttonIndex) {
                    
                    titleColor = LCColor(255, 10, 10);
                    
                } else {
                    
                    titleColor = [UIColor blackColor] ;
                }
                [btn setTitleColor:titleColor forState:UIControlStateNormal];
                
                [btn setBackgroundImage:[UIImage imageNamed:@"bgImage_HL"] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                CGFloat btnY = BUTTON_H * (i + (title ? 1 : 0));
                [btn setFrame:CGRectMake(0, btnY, SCREEN_SIZE.width, BUTTON_H)];
                [bottomView addSubview:btn];
            }
            
            for (int i = 0; i < titles.count; i++) {
                
                // 所有线条
                UIImageView *line = [[UIImageView alloc] init];
                [line setImage:[UIImage imageNamed:@"cellLine"]];
                [line setContentMode:UIViewContentModeCenter];
                CGFloat lineY = (i + (title ? 1 : 0)) * BUTTON_H;
                [line setFrame:CGRectMake(0, lineY, SCREEN_SIZE.width, 1.0f)];
                [bottomView addSubview:line];
            }
        }
        
        // 取消按钮
        UIButton *cancelBtn = [[UIButton alloc]init];
        [cancelBtn setTag:titles.count];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [[cancelBtn titleLabel] setFont:[UIFont systemFontOfSize:16.0f]];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"bgImage_HL"] forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(didClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnY = BUTTON_H * (titles.count + (title ? 1 : 0)) + 5.0f;
        [cancelBtn setFrame:CGRectMake(0, btnY, SCREEN_SIZE.width, BUTTON_H)];
        [bottomView addSubview:cancelBtn];
        
        CGFloat bottomH = (title ? BUTTON_H : 0) + BUTTON_H * titles.count + BUTTON_H + 5.0f;
        [bottomView setFrame:CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, bottomH)];
        
        [self setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [self.backWindow addSubview:self];
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
               redButtonIndex:(NSInteger)buttonIndex
                       bounds:(CGSize)bounds
                 buttonHeight:(CGFloat)height
             actionSheetColor:(UIColor *)actionSheetColor
                   titleColor:(UIColor *)titleColor
                  cancelColor:(UIColor *)cancelTextColor
         cancelBackgoundColor:(UIColor *)cancelBackgoundColor
                     delegate:(id<PopActionSheetDelegate>)delegate {
    
    if (self = [super init]) {
        
        _delegate = delegate;
        
        // 暗黑色的view
        UIView *windowView = [[UIView alloc] init];
        [windowView setAlpha:0];
        [windowView setUserInteractionEnabled:NO];
        [windowView setFrame:(CGRect){0, 0, bounds}];
        [windowView setBackgroundColor:LCColor(46, 49, 50)];
        [self addSubview:windowView];
        _darkView = windowView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [windowView addGestureRecognizer:tap];
        
        // 所有按钮的底部view
        UIView *bottomView = [[UIView alloc] init];
        [bottomView setBackgroundColor:actionSheetColor];
        [self addSubview:bottomView];
        _bottomView = bottomView;
        
        if (title) {
            
            // 标题
            UILabel *label = [[UILabel alloc] init];
            [label setText:title];
            [label setTextColor:titleColor];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:[UIFont systemFontOfSize:13.0f]];
            [label setBackgroundColor:[UIColor whiteColor]];
            [label setFrame:CGRectMake(0, 0, bounds.width, height)];
            [bottomView addSubview:label];
        }
        
        if (titles.count) {
            
            _buttonTitles = titles;
            
            for (int i = 0; i < titles.count; i++) {
                
                // 所有按钮
                UIButton *btn = [[UIButton alloc] init];
                [btn setTag:i];
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn setTitle:titles[i] forState:UIControlStateNormal];
                [[btn titleLabel] setFont:[UIFont systemFontOfSize:16.0f]];
                
                UIColor *titleColor = nil;
                if (i == buttonIndex) {
                    
                    titleColor = LCColor(255, 10, 10);
                    
                } else {
                    
                    titleColor = [UIColor blackColor] ;
                }
                [btn setTitleColor:titleColor forState:UIControlStateNormal];
                
                [btn setBackgroundImage:[UIImage imageNamed:@"bgImage_HL"] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                CGFloat btnY = height * (i + (title ? 1 : 0));
                [btn setFrame:CGRectMake(0, btnY, bounds.width, height)];
                [bottomView addSubview:btn];
            }
            
            for (int i = 0; i < titles.count; i++) {
                
                // 所有线条
                UIImageView *line = [[UIImageView alloc] init];
                [line setImage:[UIImage imageNamed:@"cellLine"]];
                [line setContentMode:UIViewContentModeCenter];
                CGFloat lineY = (i + (title ? 1 : 0)) * height;
                [line setFrame:CGRectMake(0, lineY, bounds.width, 1.0f)];
                [bottomView addSubview:line];
            }
        }
        
        // 取消按钮
        UIButton *cancelBtn = [[UIButton alloc]init];
        [cancelBtn setTag:titles.count];
        [cancelBtn setBackgroundColor:cancelBackgoundColor];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [[cancelBtn titleLabel] setFont:[UIFont systemFontOfSize:16.0f]];
        [cancelBtn setTitleColor:cancelTextColor forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"bgImage_HL"] forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(didClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnY = height * (titles.count + (title ? 1 : 0)) + 5.0f;
        [cancelBtn setFrame:CGRectMake(0, btnY, bounds.width, height)];
        [bottomView addSubview:cancelBtn];
        
        CGFloat bottomH = (title ? height : 0) + height * titles.count + height + 5.0f;
        [bottomView setFrame:CGRectMake(0, bounds.height, bounds.width, bottomH)];
        
        [self setFrame:(CGRect){0, 0, bounds}];
        [self.backWindow addSubview:self];
    }
    
    return self;
}

#pragma mark delegate

- (void)didClickBtn:(UIButton *)btn {
    
    [self dismiss:nil];
    
    if ([_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
        
        [_delegate actionSheet:self didClickedButtonAtIndex:btn.tag];
    }
}

- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0];
                         [_darkView setUserInteractionEnabled:NO];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y += frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     } completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];
                     }];
}

- (void)didClickCancelBtn {
    
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0];
                         [_darkView setUserInteractionEnabled:NO];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y += frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     } completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];
                         
                         if ([_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
                             
                             [_delegate actionSheet:self didClickedButtonAtIndex:_buttonTitles.count];
                         }
                     }];
}

#pragma mark show methods

- (void)show {
    
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0.4f];
                         [_darkView setUserInteractionEnabled:YES];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y -= frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     } completion:nil];
}

- (void)show:(NSTimeInterval)duration {
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0.4f];
                         [_darkView setUserInteractionEnabled:YES];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y -= frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     } completion:nil];
}

- (void)show:(NSTimeInterval)duration options:(UIViewAnimationOptions)option{
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:option
                     animations:^{
                         
                         [_darkView setAlpha:0.4f];
                         [_darkView setUserInteractionEnabled:YES];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y -= frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     } completion:nil];
}

#pragma mark getter and setter

- (UIWindow *)backWindow
{
    if (_backWindow == nil) {
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    return _backWindow;
}
@end
