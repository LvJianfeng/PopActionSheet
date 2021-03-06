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



    PopActionSheet *sheet = [PopActionSheet popSheetWithTitle:@"我是要测试的"
                                                 buttonTitles:@[@"确定",@"不确定",@"可能确定的吧"]
                                               redButtonIndex:-1
                                                       bounds:screen.bounds.size
                                                 buttonHeight:49.0f
                                             actionSheetColor:[UIColor lightGrayColor]
                                                   titleColor:[UIColor blueColor]
                                                  cancelColor:[UIColor orangeColor] cancelBackgoundColor:[UIColor       lightGrayColor] delegate:self];
    
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


# Reachability

ios 网络状态监测

# 使用方法

只需要将Reachability.h 和 Reachability.m 添加到你的工程文件。

# 代码使用

    #pragma mark Reachability
    - (void)reachabilityStatus
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
        self.internetReachability = [Reachability reachabilityForInternetConnection];
        [self.internetReachability startNotifier];
        [self updateInterfaceWithReachability:self.internetReachability];
    }

    - (void)reachabilityChanged:(NSNotification *)note
    {
        Reachability *curReach = [note object];
        NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
        [self updateInterfaceWithReachability:curReach];
    }

    - (void)updateInterfaceWithReachability:(Reachability *)reachability
    {
        NetworkStatus status = [reachability currentReachabilityStatus];
    
        switch (status)
        {
            case NotReachable:
                DDLogWarn(@"没有网络连接");
                break;
            
            case ReachableViaWiFi:
            case ReachableViaWWAN:
                DDLogWarn(@"无线网");
                break;
            
            case kReachableVia2G:
                DDLogWarn(@"2G");
                break;
            
            case kReachableVia3G:
                DDLogWarn(@"3G");
                break;
            
            case kReachableVia4G:
                DDLogWarn(@"4G");
                break;
        }
    }

# JFGlobalInstance 单例

设置全局字体；获取本地plist文件（自己修改添加需要的）

    - (NSString *)loadPlistFile:(NSString *)fileNameWithoutExtension //获取本地plist文件
    
# UIColor 的类目文件

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

# UINavigationBar 的类目文件
    //设置UINavgationBar的背景颜色
    - (void)setCustomBackgroundColor:(UIColor *)backgroundColor;
    //设置内容的透明度
    - (void)setCustomContentAlpha:(CGFloat)alpha;
    //滚动的时候设置y轴
    - (void)setCustomTranslationY:(CGFloat)translationY;
    //重置
    - (void)reset;
