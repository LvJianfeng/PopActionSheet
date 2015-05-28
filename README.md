# PopActionSheet

类似微信，微博的弹出窗风格。

# 说明

两个类方法，两个实例方法，方便个人自定义弹出风格，替换弹出动画等。

根据自己的需求就控制点击按钮的颜色，弹出框的背景颜色等。

# 使用方法

只需要将PopActionSheet.h 和 PopActionSheet.m，以及Image文件夹的两个png图片放到你的工程文件。

# 代码使用

PopActionSheet *sheet = [PopActionSheet popSheetWithTitle:nil
                                            buttonTitles:@[@"拍照", @"从相册选择"]
                                          redButtonIndex:-1
                                                delegate:self];

    [sheet show];


PopActionSheet *sheet = [[PopActionSheet alloc] initWithTitle:@"你确定要注销吗？"
                                                   buttonTitles:@[@"确定"]
                                                 redButtonIndex:0
                                                       delegate:self];
    [sheet show];



PopActionSheet *sheet = [PopActionSheet popSheetWithTitle:@"我是要测试的" buttonTitles:@[@"确定",@"不确定",@"可能确定的吧"] redButtonIndex:-1 bounds:screen.bounds.size buttonHeight:49.0f actionSheetColor:[UIColor lightGrayColor] titleColor:[UIColor blueColor] cancelColor:[UIColor orangeColor] cancelBackgoundColor:[UIColor lightGrayColor] delegate:self];
    
    [sheet show:0.3f];




# 类方法
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

