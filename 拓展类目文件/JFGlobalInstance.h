//
//  JFGlobalInstance.h
//  JFPersonPage
//
//  Created by Lvjianfeng on 15/5/27.
//  Copyright (c) 2015年 CoderJianfeng. All rights reserved.
//
//  https://github.com/LvJianfeng
//  http://weibo.com/aaalizzwell
#import <Foundation/Foundation.h>

@interface JFGlobalInstance : NSObject

+ (id)shareIntance;


- (NSString *)appSystemFont:(NSString *)fontPlistName;
@end
