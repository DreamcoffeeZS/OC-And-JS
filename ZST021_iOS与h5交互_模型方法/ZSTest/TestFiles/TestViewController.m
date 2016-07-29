//
//  TestViewController.m
//  Test
//
//  Created by zhoushuai on 16/3/7.
//  Copyright © 2016年 zhoushuai. All rights reserved.
//


#import "TestViewController.h"
#import "JSHandler.h"

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
    
    
    //第三步：在webView所在的视图控制中，创建JSContext对象，使用协议方法
    JSContext *jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    JSHandler *jsHandler = [JSHandler new];
    jsContext[@"javascript"] = jsHandler;
    
}


#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
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
