//
//  UpdateContactViewController.h
//  作业16数据库通讯录
//
//  Created by lanou3g on 14-6-15.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactPerson;
@interface UpdateContactViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,retain)ContactPerson * person;
@end
