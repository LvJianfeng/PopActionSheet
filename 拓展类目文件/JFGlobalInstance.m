//
//  JFGlobalInstance.m
//  JFPersonPage
//
//  Created by Lvjianfeng on 15/5/27.
//  Copyright (c) 2015年 CoderJianfeng. All rights reserved.
//
//  https://github.com/LvJianfeng
//  http://weibo.com/aaalizzwell
#import "JFGlobalInstance.h"

@implementation JFGlobalInstance

+ (id)shareIntance
{
    static JFGlobalInstance *shareJFGlobalInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareJFGlobalInstance = [[self alloc] init];
    });
    
    return shareJFGlobalInstance;
}

- (NSString *)appSystemFont:(NSString *)fontPlistName
{
    NSString *filename = [self loadPlistFile:fontPlistName];
    if (filename) {
        NSString *font = [[NSDictionary dictionaryWithContentsOfFile:filename] objectForKey:@"SysFont"];
        return font;
    }
    
    return @"HelveticaNeue-Thin";//@"Avenir-Light";
}

- (NSString *)loadPlistFile:(NSString *)fileNameWithoutExtension
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath = [pathArray objectAtIndex:0];
    NSString *filename=[plistPath stringByAppendingPathComponent:[fileNameWithoutExtension stringByAppendingString:@".plist"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filename]){
        return filename;
    }
    return nil;
}



@end
