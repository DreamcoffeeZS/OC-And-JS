//
//  JSHandler.m
//  ZSTest
//
//  Created by zhoushuai on 16/7/29.
//  Copyright © 2016年 zhoushuai. All rights reserved.
//

#import "JSHandler.h"

#import <JavaScriptCore/JavaScriptCore.h>

@implementation JSHandler:NSObject

//第二步：实现协议方法
#pragma mark - 实现代理方法
//单参数方法
- (void)sayHello:(NSString *)greeting{
    NSLog(@"%s", __func__);
    NSLog(@"%@",greeting);
}

//两个参数的方法
- (void)sayHelloTo:(NSString *)name WithGreeting:(NSString *)greeting{
    NSLog(@"%s", __func__);
    NSLog(@"%@,%@",name,greeting);
}

@end
