//
//  TestViewController.m
//  Test
//
//  Created by zhoushuai on 16/3/7.
//  Copyright © 2016年 zhoushuai. All rights reserved.
//


#import "TestViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface TestViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationController.navigationBar.translucent = NO;
    
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;

    //使用本地的h5文件加载一个网页
     NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"testWebPage" ofType:@"html"];
     NSError *error = nil;
     NSString  *str = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:&error];
     [self.webView loadHTMLString:str baseURL:nil];
}


#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
   
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //获取JSContext对象
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //sayHello就是js的方法名称，使用一个block对应赋值
    
    __weak typeof (self) weakSelf = self;
    context[@"sayHello"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSString *objString = [NSString stringWithFormat:@"%@",args[0]] ;
        if (objString.length >0) {
            //得到参数之后，这里可以使用调用OC方法，即实现了JS对于OC的调用
            [weakSelf printInfo:objString];

          }
     };
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}


#pragma mark - 事件点击
- (void)printInfo:(NSObject *)obj{
    NSString *info = [NSString stringWithFormat:@"%@",obj];
    NSLog(@"打印JS传递的info:%@",info
          );
    
}





@end
