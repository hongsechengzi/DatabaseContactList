//
//  ContactPerson.h
//  作业16数据库通讯录
//
//  Created by lanou3g on 14-6-13.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactPerson : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * age;
@property(nonatomic,assign)NSInteger  number;
@property(nonatomic,copy)NSString * phoneNumber;
@property(nonatomic,copy)NSString * introduce;
@property(nonatomic,copy)NSString * imagePath;
@property(nonatomic,copy)NSString * groupName;
@property(nonatomic,retain)UIImage * avatarImage;
- (instancetype)initWithNumber:(NSInteger)number name:(NSString *)name age:(NSString *)age sex:(NSString *)sex phoneNumber:(NSString *)phoneNumber introduce:(NSString *)introduce imagePath:(NSString *)imagePath groupName:(NSString *)groupName;
@end
