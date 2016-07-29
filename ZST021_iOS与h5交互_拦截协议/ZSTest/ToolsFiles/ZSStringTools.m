//
//  CommonTools.m
//  ZSTest
//
//  Created by zhoushuai on 16/4/8.
//  Copyright © 2016年 zhoushuai. All rights reserved.
//

#import "ZSStringTools.h"

@implementation ZSStringTools

#pragma mark - 字符串其他操作

NSString * getSafeString(id object)
{
    NSString *string = nil;
    if ([object isKindOfClass:[NSNull class]]||object==nil||[[NSString stringWithFormat:@"%@",object] isEqualToString:@"(null)"]) {
        string = @"";
    }else
    {
        string = [NSString stringWithFormat:@"%@",object];
    }
    return string;
}



/**
 去掉首尾空格
 @param str 字符串
 @returns 去掉首尾空格的字符串
 */
+(NSString*)clearWhiteSpace:(NSString*)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
}

/**
 去掉首尾空格和换行符
 @param str 字符串
 @returns 去掉首尾空格和换行符的字符串
 */
+(NSString*)clearWhiteSpaceAndNewLineCharacter:(NSString*)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


 


//根据字号和宽度获取文字高度
+ (CGFloat)getTextHeightWithString:(NSString *)text
                         viewWidth:(CGFloat)width
                          textSize:(NSInteger)textSize{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:textSize]} context:nil];
    return rect.size.height;
}

//根据字号和高度获取宽度
+ (CGFloat)getTextWidthWithString:(NSString *)text
                       viewHeight:(CGFloat)height
                         textSize:(NSInteger)textSize{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(1000, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:textSize]} context:nil];
    return rect.size.width;
    
}


@end
