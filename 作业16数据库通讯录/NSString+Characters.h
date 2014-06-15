//
//  NSString+Characters.h
//  AddressBook
//
//  Created by lanou3g on 14-6-10.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Characters)

//将汉字转换为拼音
- (NSString *)pinyinOfName;

//汉字转换为拼音后，返回大写的首字母
- (NSString *)firstCharacterOfName;

@end
