//
//  ContactPerson.m
//  作业16数据库通讯录
//
//  Created by lanou3g on 14-6-13.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ContactPerson.h"
#import "NSString+Characters.h"

@implementation ContactPerson
- (void)dealloc
{
    RELEASE_SAFELY(_name);
    RELEASE_SAFELY(_groupName);
    RELEASE_SAFELY(_sex);
    RELEASE_SAFELY(_age);
    RELEASE_SAFELY(_phoneNumber);
    RELEASE_SAFELY(_introduce);
    RELEASE_SAFELY(_imagePath);    
    [super dealloc];
}
- (instancetype)initWithNumber:(NSInteger)number name:(NSString *)name age:(NSString *)age sex:(NSString *)sex phoneNumber:(NSString *)phoneNumber introduce:(NSString *)introduce imagePath:(NSString *)imagePath groupName:(NSString *)groupName
{
    self = [super init];
    if (self) {
        self.number = number;
        self.name = name;
        self.age = age;
        self.sex = sex;
        self.phoneNumber = phoneNumber;
        self.introduce = introduce;
        self.imagePath = imagePath;
        self.groupName = groupName;
    }
    return self;
}
- (void)setName:(NSString *)name
{
    if (_name != name) {
        [_name release];
        _name = [name copy];
    }
    self.groupName = [_name firstCharacterOfName];
}

//- (void)setNumber:(NSInteger)number
//{
//   
//    NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString * imageDirectory = [cachesPath stringByAppendingPathComponent:@"imageDirectory"];
//    self.imagePath= [imageDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"h%ld",_number]];
//}
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.avatarImage forKey:@"avatarImage"];
//
//}
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super init];
//    if (self) {
//        self.avatarImage = [aDecoder decodeObjectForKey:@"avatarImage"];
//    }
//    return self;
//}

- (void)saveImageViewDataArchiver
{
//    NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString * imageDirectory = [cachesPath stringByAppendingPathComponent:@"imageDirectory"];
//    NSString * imageFilePath = [imageDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"h%ld",_number]];
    NSLog(@"%s",__FUNCTION__);
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_avatarImage forKey:@"avatarImage"];
    [archiver finishEncoding];
    [data writeToFile:_imagePath atomically:YES];
}

@end
