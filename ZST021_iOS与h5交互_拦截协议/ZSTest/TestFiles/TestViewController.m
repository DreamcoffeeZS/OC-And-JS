//
//  TestViewController.m
//  Test
//
//  Created by zhoushuai on 16/3/7.
//  Copyright © 2016年 zhoushuai. All rights reserved.
//


#import "TestViewController.h"

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
        //获取此时的URL
        //'http://www.testwebpage/?funcName=printInfo:&&info=helloword'
        NSURL *url = [request URL];
        NSString *completeString = [url absoluteString];
    
        //第一步:检测链接中的特殊字段
        NSString *needCheckStr = @"http://www.testwebpage/?";
        NSRange jumpRange = [completeString rangeOfString:needCheckStr];
        if (jumpRange.location != NSNotFound) {
        /*
         1.检测到链接中包含有特殊字段，客户端要接受响应并做后续处理
            这就相当于js调起了iOS，
         2.在真实的使用时，客户端需要和h5协调，双方需要统一监听的字段
         3.参数问题：如果此时的交互需要传递参数，参数也可以放在链接里，
                   同样通过识别字符串的方法来获取
         */
            
        //第二步：拿到链接字符串的后续部分，然后分割字符串得到参数数据
        NSMutableString *linkmStr = [NSMutableString stringWithString:completeString];
        NSRange deleteRange = {0,needCheckStr.length};
        [linkmStr deleteCharactersInRange:deleteRange];
        NSArray *params = [linkmStr componentsSeparatedByString:@"&&"];
        //取出第一个参数：与h5协商好的方法名
        NSString *funcName = [params[0] componentsSeparatedByString:@"="][1];
       //取出第二个参数：信息字符串
        NSString *info = [params[1] componentsSeparatedByString:@"="][1];
        
        //第三步：调起iOS原生方法
        SEL ocFunc = NSSelectorFromString(funcName);
        if ([self respondsToSelector:ocFunc]) {
        //使用编译预处理，不显示警告提示
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:ocFunc withObject:info];
        #pragma clang diagnostic pop

        }
        //返回NO是为了不再执行点击原链接的跳转
        return NO;
    }
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
