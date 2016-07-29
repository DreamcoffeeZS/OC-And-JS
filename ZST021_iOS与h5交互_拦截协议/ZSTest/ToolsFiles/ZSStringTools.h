//
//  CommonTools.h
//  ZSTest
//
//  Created by zhoushuai on 16/4/8.
//  Copyright © 2016年 zhoushuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface ZSStringTools : NSObject

#pragma mark - 字符串其他操作
/**
 *  对象类型转化为安全的字符串
 *
 *  @param 对象
 *
 *  @return nssstring
 */
NSString* getSafeString(id object);

/**
 去掉首尾空格
 @param str 字符串
 @returns 去掉首尾空格的字符串
 */
+(NSString*)clearWhiteSpace:(NSString*)str;

/**
 去掉首尾空格和换行符
 @param str 字符串
 @returns 去掉首尾空格和换行符的字符串
 */
+(NSString*)clearWhiteSpaceAndNewLineCharacter:(NSString*)str;


 


//根据字号和宽度获取文字高度
+ (CGFloat)getTextHeightWithString:(NSString *)text
                         viewWidth:(CGFloat)width
                          textSize:(NSInteger)textSize;

//根据字号和高度获取宽度
+ (CGFloat)getTextWidthWithString:(NSString *)text
                       viewHeight:(CGFloat)height
                         textSize:(NSInteger)textSize;


@end
