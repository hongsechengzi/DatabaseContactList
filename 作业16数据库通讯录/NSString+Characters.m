//
//  NSString+Characters.m
//  AddressBook
//
//  Created by lanou3g on 14-6-10.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "NSString+Characters.h"

@implementation NSString (Characters)


- (NSString *)pinyinOfName
{
    NSMutableString * name = [[[NSMutableString alloc] initWithString:self ] autorelease];
    
    CFRange range = CFRangeMake(0, 1);
    
    // 汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) name, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) name, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    
    return name;
}

- (NSString *)firstCharacterOfName
{
    
    
    NSMutableString * first = [[[NSMutableString alloc] initWithString:[self substringWithRange:NSMakeRange(0, 1)]] autorelease];
    
    CFRange range = CFRangeMake(0, 1);
    
    // 汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    
    NSString * result;
    result = [first substringWithRange:NSMakeRange(0, 1)];
    
    return result.uppercaseString;
}


@end
