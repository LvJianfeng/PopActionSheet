# PopActionSheet

类似微信，微博的弹出窗风格。

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

