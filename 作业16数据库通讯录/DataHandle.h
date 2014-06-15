//
//  DataHandle.h
//  作业16数据库通讯录
//
//  Created by lanou3g on 14-6-13.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ContactPerson;
@interface DataHandle : NSObject
@property(nonatomic,retain)NSMutableDictionary * allContactDic;
@property(nonatomic,retain)NSMutableArray * allGroupNameArray;
+ (DataHandle *)shareInstance;
//根据索引section得到分组个数
- (NSInteger)countOfOneGroupWithSection:(NSInteger)section;
//根据indexPath得到person
- (ContactPerson *)contactPersonOfOneGroupWithIndexPath:(NSIndexPath *)indexPath;
//根据索引section得到分组名
- (NSString *)groupNameWithSection:(NSInteger)section;

//添加联系人
//- (void)addNewContactPerson:(ContactPerson *)person;

//数据库插入person
- (void)insertNewContactPerson:(ContactPerson *)person;
//数据库删除联系人
- (void)deleteContactPersonOfDBWithIndexPath:(NSIndexPath *)indexPath;
//数据库更新联系人
- (void)updateContactPersonInformation:(ContactPerson *)person;
@end
