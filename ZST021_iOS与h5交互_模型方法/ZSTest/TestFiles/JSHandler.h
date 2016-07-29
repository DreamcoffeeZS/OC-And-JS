//
//  JSHandler.h
//  ZSTest
//
//  Created by zhoushuai on 16/7/29.
//  Copyright © 2016年 zhoushuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

//第一步：创建一个用与JS交互的类JSHandler继承与NSObject
//在类中声明一个遵守JSExport的协议，并且使JSHandler实现这个新的协议
@protocol JSHandlerProtocol <JSExport>
//单参数方法
- (void)sayHello:(NSString *)greeting;

//多参数的方法
//由于涉及到多参数的问题，从第二个参数开始，外部参数名都要使用大写开头
//因为JS调用OC方法时，是将OC方法拼接连成字符串，如果无法区分就会造成无法识别
//比如对于下面的OC方法，JS调用时
//javascript.sayHelloToWithGreeting(‘参数1’，参数2) //正确写法
//javascript.sayHelloTowithGreeting(‘参数1’，参数2) //错误写法
- (void)sayHelloTo:(NSString *)name WithGreeting:(NSString *)greeting;

@end

@interface JSHandler : NSObject<JSHandlerProtocol>

@end
