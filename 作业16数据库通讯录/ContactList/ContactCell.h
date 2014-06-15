//
//  ContactCell.h
//  作业16数据库通讯录
//
//  Created by lanou3g on 14-6-14.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactPerson;
@interface ContactCell : UITableViewCell
@property(nonatomic,readonly)UIImageView * avatarImageView;
@property(nonatomic,readonly)UILabel * nameLabel;
@property(nonatomic,readonly)UILabel * phoneNumberLabel;
@property(nonatomic,readonly)UILabel * introduceLabel;

@property(nonatomic,retain)ContactPerson * person;

@end
