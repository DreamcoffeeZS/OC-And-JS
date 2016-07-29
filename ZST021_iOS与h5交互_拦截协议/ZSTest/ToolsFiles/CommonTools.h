//
//  CommonTools.h
//  ZSTest
//
//  Created by zhoushuai on 16/7/16.
//  Copyright © 2016年 zhoushuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonTools : NSObject


#pragma mark - 有关系统的操作
//获取系统的版本号
+(float)getSystemVersion;

/**
 @returns 获得唯一识别码
 */
+ (NSString *)getUUID;

//判断运行的设备是否iphone，如果是则返回true，否则返回false
+ (BOOL)getRuntimeClassIsIphone;


#pragma mark - 有关于数据的操作
/*将NULL转换为“”，能直接存储成字典，不会崩溃*/
+ (NSDictionary *)cleanNullClassFromDictionary:(NSDictionary *)dataDict;



#pragma mark 读取plist文件
/**
 *  解析plist文件获取数据，返回数组
 *  @param fileName plist文件的文件名
 *  @return 数组
 */
+ (NSArray *)getArrayFromPlistData:(NSString *)fileName;


/**
 *  解析plist文件数据,返回数组
 *  @param fileName plist文件的文件名
 *  @return 字典
 */
+ (NSDictionary *)getDictionaryFromPlistData:(NSString *)fileName;


#pragma mark 读取Json文件

/**
 *  解析本地Json文件，返回id
 *  @param fileName 本地json文件的文件名
 *  @return id类型字典或者数组
 */
+ (id)getJsonData:(NSString *)fileName;

/**
 *  解析本地json数据,返回数组
 *  @param fileName jion文件名
 *  @return  数组
 */
+ (NSArray *)getArrayFromJsonData:(NSString *)fileName;


/**
 *  解析本地json数据，返回字典
 *  @param fileName jion文件名
 *  @return  字典
 */
+ (NSDictionary *)getDictionaryFromJsonData:(NSString *)fileName;




#pragma mark - 有关界面的操作
//16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *)colorFromHexString:(NSString *) stringToConvert;







@end
