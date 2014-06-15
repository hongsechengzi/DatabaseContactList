//
//  DataHandle.m
//  作业16数据库通讯录
//
//  Created by lanou3g on 14-6-13.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "DataHandle.h"
#import <sqlite3.h>
#import "ContactPerson.h"
#define CONTACTLISTFILEPATH @"通讯录.sqlite"

@interface DataHandle ()
@property(nonatomic,retain)NSFileManager * fileManager;

@end

@implementation DataHandle

- (void)dealloc
{
    RELEASE_SAFELY(_allContactDic);
    RELEASE_SAFELY(_allGroupNameArray);
    RELEASE_SAFELY(_fileManager);
    [super dealloc];
}
//创建数据库
static DataHandle * handle = nil;

+ (DataHandle *)shareInstance
{
    if (nil == handle) {
        handle = [[DataHandle alloc] init];
        [handle handleTableViewData];
       [handle openDB];
    }
    return handle;
}
+ (instancetype)alloc
{
    if (nil == handle) {
        handle = [super alloc];
        return handle;
    }
    return nil;
}
//打开数据库
static sqlite3 * db = nil;
- (void)openDB
{
    if (nil != db) {
        return;
    }
   
    NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString * filePath = [cachesPath stringByAppendingPathComponent:CONTACTLISTFILEPATH];
    NSLog(@"filePath = %@",filePath);
    
    int result = sqlite3_open([filePath UTF8String], &db);
    NSLog(@"%d",result);
    //创建图像目录
    NSString * imageDirectory = [cachesPath stringByAppendingPathComponent:@"imageDirectory"];
    
    [_fileManager createDirectoryAtPath:imageDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (SQLITE_OK == result) {
      
        NSString * createSql = @"CREATE TABLE ContactList (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age TEXT, sex TEXT NOT NULL, phoneNumber TEXT, introduce TEXT, imagePath TEXT, groupName TEXT)";
        sqlite3_exec(db, [createSql UTF8String], NULL, NULL, NULL);
    }
  
}
- (void)closeDB
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"关闭数据库成功");
        db = nil;
    }
}
//在数据库中插入联系人
- (void)insertNewContactPerson:(ContactPerson *)person
{
    [handle addNewContactPerson:person];
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    NSString * sql = @"insert into ContactList(name, age, sex, phoneNumber, introduce, imagePath, groupName) values(?,?,?,?,?,?,?)";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (SQLITE_OK == result) {
        sqlite3_bind_text(stmt, 1, [person.name UTF8String], -1, NULL);
         sqlite3_bind_text(stmt, 2, [person.age UTF8String], -1, NULL);
         sqlite3_bind_text(stmt, 3, [person.sex UTF8String], -1, NULL);
         sqlite3_bind_text(stmt, 4, [person.phoneNumber UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 5, [person.introduce UTF8String], -1, NULL);
         sqlite3_bind_text(stmt, 6, [person.imagePath UTF8String], -1, NULL);
         sqlite3_bind_text(stmt, 7, [person.groupName UTF8String], -1, NULL);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    NSInteger ab = sqlite3_last_insert_rowid(db);
    NSLog(@"++++++++++lalalaa%ld",ab);
    //添加imagePath
    NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString * imageDirectory = [cachesPath stringByAppendingPathComponent:@"imageDirectory"];
    person.imagePath= [imageDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"h%ld",ab]];
    [handle saveImageViewDataArchiverWithPerson:person];
    [handle updateContactPersonImagePath:person.imagePath withNamber:ab];
}

//在数据库中删除联系人
- (void)deleteContactPersonOfDBWithIndexPath:(NSIndexPath *)indexPath
{
    ContactPerson * person = [handle contactPersonOfOneGroupWithIndexPath:indexPath];
    [handle deleteContactPersonOfOneGroupWithIndexPath:indexPath];
    //删除照片
    [_fileManager removeItemAtPath:person.imagePath error:nil];
    //[_fileManager removeItemAtPath:person.imagePath error:nil];
    [self openDB];
    sqlite3_stmt * stmt = nil;
    NSString * sql = @"delete from ContactList where number = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    NSLog(@"闪人%d",result);
    if (SQLITE_OK == result) {
        sqlite3_bind_int64(stmt, 1, person.number);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}
//数据库更新联系人
- (void)updateContactPersonInformation:(ContactPerson *)person
{
    NSLog(@"person update %@",person.name);
    [self openDB];
    sqlite3_stmt * stmt = nil;
    NSString * sql = @"update ContactList set name = ?,age = ?,sex = ?,phoneNumber = ?,introduce = ?,groupName = ? where number = ?";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    NSLog(@"%d",result);
    if (SQLITE_OK == result) {
        sqlite3_bind_text(stmt, 1, [person.name UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [person.age UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [person.sex UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [person.phoneNumber UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 5, [person.introduce UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 6, [person.groupName UTF8String], -1, NULL);
        sqlite3_bind_int64(stmt, 7, person.number);
        sqlite3_step(stmt);
        
    }
    sqlite3_finalize(stmt);
    [handle saveImageViewDataArchiverWithPerson:person];
    
     [handle getImageViewDataUnarchiverWithPerson:person];
    NSLog(@"person update %@",person.name);
    handle.allContactDic = [NSMutableDictionary dictionaryWithDictionary:[handle selectAllContactPersonsDic]];
    handle.allGroupNameArray = [[[NSMutableArray alloc] initWithArray:[_allContactDic allKeys]] autorelease];
    [_allGroupNameArray sortUsingSelector:@selector(compare:)];
    
   
}

//根据number更改图像地址
- (void)updateContactPersonImagePath:(NSString *)imagePath withNamber:(NSUInteger)number
{
    [self openDB];
    sqlite3_stmt * stmt = nil;
    NSString * sql = @"update ContactList set imagePath = ? where number = ?";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    NSLog(@"%d",result);
    if (SQLITE_OK == result) {
        sqlite3_bind_text(stmt, 1, [imagePath UTF8String], -1, NULL);
        sqlite3_bind_int64(stmt, 2, number);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

//从数据库中取出所有联系人得字典
- (NSMutableDictionary *)selectAllContactPersonsDic
{
    [self openDB];
    sqlite3_stmt * stmt = nil;
    NSString * sql = @"select * from ContactList";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (SQLITE_OK == result) {
        NSMutableDictionary * allContactDic = [NSMutableDictionary dictionary];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
           NSInteger number =sqlite3_column_int(stmt, 0);
        NSString * name =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSString * age =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSString * sex =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            NSString * phoneNumber =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
             NSString * introduce =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
           NSString * imagePath =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
            NSString * groupName =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
            ContactPerson * person = [[ContactPerson alloc] initWithNumber:number name:name age:age sex:sex phoneNumber:phoneNumber introduce:introduce imagePath:imagePath groupName:groupName];
            [handle getImageViewDataUnarchiverWithPerson:person];
        NSMutableArray * gruop = [allContactDic objectForKey:groupName];
            if (gruop != nil) {
                [gruop addObject:person];
            }else{
                NSMutableArray * newGroup = [NSMutableArray arrayWithObject:person];
                [allContactDic setObject:newGroup forKey:groupName];
            }
        }
        sqlite3_finalize(stmt);
        return allContactDic;
    }
    sqlite3_finalize(stmt);
    return nil;
}
#pragma mark   ----归档------------
- (void)saveImageViewDataArchiverWithPerson:(ContactPerson *)person
{
    NSLog(@"%s",__FUNCTION__);
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:person.avatarImage forKey:@"avatarImage"];
    [archiver finishEncoding];
    [data writeToFile:person.imagePath atomically:YES];
}
//反归档
- (void)getImageViewDataUnarchiverWithPerson:(ContactPerson *)person
{
    NSData * data = [NSData dataWithContentsOfFile:person.imagePath];
   // NSLog(@"person.imagePath = %@",person.imagePath);
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    person.avatarImage = [unarchiver decodeObjectForKey:@"avatarImage"];
    [unarchiver finishDecoding];
}

#pragma mark ----------处理字典数组数据----------------
//处理数据
- (void)handleTableViewData
{
    self.fileManager = [[[NSFileManager alloc] init] autorelease];
    
    NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString * contactListFilePath = [cachesPath stringByAppendingPathComponent:CONTACTLISTFILEPATH];
    
    if ([_fileManager fileExistsAtPath:contactListFilePath] == 0) {
        handle.allContactDic = [[[NSMutableDictionary alloc] initWithCapacity:30] autorelease];
        handle.allGroupNameArray = [[[NSMutableArray alloc] initWithArray:[_allContactDic allKeys]] autorelease];
        [_allGroupNameArray sortUsingSelector:@selector(compare:)];
    }else{
        handle.allContactDic = [NSMutableDictionary dictionaryWithDictionary:[handle selectAllContactPersonsDic]];
        handle.allGroupNameArray = [[[NSMutableArray alloc] initWithArray:[_allContactDic allKeys]] autorelease];
        [_allGroupNameArray sortUsingSelector:@selector(compare:)];
    }
}
//根据indexPath得到分组个数
- (NSInteger)countOfOneGroupWithSection:(NSInteger)section
{
    NSString * groupName =  [_allGroupNameArray objectAtIndex:section];
    NSArray * group = [_allContactDic objectForKey:groupName];
    return [group count];
}
//根据indexPath得到person
- (ContactPerson *)contactPersonOfOneGroupWithIndexPath:(NSIndexPath *)indexPath
{
    NSString * groupName =  [_allGroupNameArray objectAtIndex:indexPath.section];
    NSMutableArray * group = [_allContactDic objectForKey:groupName];
    return [group objectAtIndex:indexPath.row];
}
//根据索引section得到分组名
- (NSString *)groupNameWithSection:(NSInteger)section
{
 return [_allGroupNameArray objectAtIndex:section];
}
//添加联系人
- (void)addNewContactPerson:(ContactPerson *)person
{
    NSMutableArray * oneGroup = [_allContactDic objectForKey:person.groupName];
    if (nil != oneGroup) {
        [oneGroup addObject:person];
    }else{
        NSMutableArray * newGroup = [NSMutableArray arrayWithObject:person];
        [_allContactDic setObject:newGroup forKey:person.groupName];
        [_allGroupNameArray addObject:person.groupName];
        [_allGroupNameArray sortUsingSelector:@selector(compare:)];
    }
}
//删除联系人
- (void)deleteContactPersonOfOneGroupWithIndexPath:(NSIndexPath *)indexPath
{
    NSString * groupName =  [_allGroupNameArray objectAtIndex:indexPath.section];
    NSMutableArray * group = [_allContactDic objectForKey:groupName];
    [group removeObjectAtIndex:indexPath.row];
    if ([group count] == 0) {
        [_allContactDic removeObjectForKey:groupName];
        [_allGroupNameArray removeObject:groupName];
    }
}

@end
