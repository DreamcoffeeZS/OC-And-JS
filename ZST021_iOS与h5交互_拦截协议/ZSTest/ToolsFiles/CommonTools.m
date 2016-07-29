//
//  CommonTools.m
//  ZSTest
//
//  Created by zhoushuai on 16/7/16.
//  Copyright © 2016年 zhoushuai. All rights reserved.
//

#import "CommonTools.h"

@implementation CommonTools
#pragma mark - 关于系统和文件
/**
 *  获取系统版本
 *
 *  @return 返回版本号
 */
+(float)getSystemVersion{
    
    CGFloat version = [[UIDevice currentDevice].systemVersion floatValue];
    return version;
    
}

 

+ (BOOL)getRuntimeClassIsIphone{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return 1;
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return 0;
    }
    else {
        //iPad
        return 0;
    }
}



#pragma mark - 有关于数据的操作
/*将NULL转换为“”，能直接存储成字典，不会崩溃*/
+ (NSDictionary *)cleanNullClassFromDictionary:(NSDictionary *)dataDict
{
    if (![dataDict isKindOfClass:[NSDictionary class]]) {
        return [NSDictionary dictionary];//添加判断
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dataDict];
    for (NSString *key in [dict allKeys]) {
        id item = [dict valueForKey:key];
        if (!item || [item isKindOfClass:[NSNull class]]) {
            [dict setValue:@"" forKey:key];
        }
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}


# pragma mark 读取plist文件
/**
 *  从plist文件中获取数组
 *  @param fileName 传入一个字符串：文件名
 *  @return 将返回数据解析为数组
 */
+ (NSArray *)getArrayFromPlistData:(NSString *)fileName{
    //第一种方法获取路径
    //根据plist文件名，获取文件路径
    NSString *filePath =[[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    //从文件中取出数组
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:filePath];
    if (dataArr == nil ) {
        return  nil;
    }
    return dataArr;
}


/**
 *  从plist中获取字典
 *  @param fileName 传入一个字符串：文件名
 *  @return 将返回数据解析为字典
 */
+ (NSDictionary *)getDictionaryFromPlistData:(NSString *)fileName{
    //第二种方法获取路径
    //得到的文件路径：文件路径= bundle路径+文件名路径
    NSString *sourcePath = [[NSBundle mainBundle] resourcePath];
    //这里用到了字符串的拼接
    NSString *file = [NSString stringWithFormat:@"%@.plist",fileName];
    NSString *filePath = [sourcePath stringByAppendingPathComponent:file];
    
    //获取字典
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (dic == nil) {
        return  nil;
    }
    return dic;
}


#pragma mark 读取Json文件
/**
 *  根据文件名，从本地的json文件中获取数据
 *  @param fileName 本地json文件名
 *  @return ：id类型（数组或者字典）
 */
+ (id)getJsonData:(NSString *)fileName{
    //1.获取json文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@".json"];
    //2.通过路径获取data
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //3.设置错误对像
    NSError *error = nil;
    //4.解析json,得到一个字典或者数组
    id  json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (json == nil) {
        NSLog(@"解析文件失败");
        return nil;
    }
    //返回数据
    return json;
}



/**
 *  解析本地json数据
 *  @param fileName jion文件名
 *  @return  数组
 */
+ (NSArray *)getArrayFromJsonData:(NSString *)fileName{
    //1.获取json文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@".json"];
    //2.通过路径获取data
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //3.设置错误对像
    NSError *error = nil;
    //4.解析json,得到一个字典或者数组
    id  jsonArr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (jsonArr== nil) {
        NSLog(@"解析文件失败");
        return nil;
    }
    //返回数据
    return jsonArr;
}


/**
 *  解析本地json数据
 *  @param fileName jion文件名
 *  @return  字典
 */
+ (NSDictionary *)getDictionaryFromJsonData:(NSString *)fileName{
    //1.获取json文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@".json"];
    //2.通过路径获取data
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //3.设置错误对像
    NSError *error = nil;
    //4.解析json,得到一个字典或者数组
    NSDictionary *  jsonDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (jsonDic == nil) {
        NSLog(@"解析文件失败");
        return nil;
    }
    //返回数据
    return jsonDic;
}





#pragma mark - 有关界面的操作

//16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *)colorFromHexString:(NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}








@end
