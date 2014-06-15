//
//  ContactDetailView.h
//  AddressBook
//
//  Created by lanou3g on 14-6-10.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTView;
@interface ContactDetailView : UIView


@property(nonatomic,readonly)LTView * nameLT;
@property(nonatomic,readonly)LTView * sexLT;
@property(nonatomic,readonly)LTView * ageLT;
@property(nonatomic,readonly)LTView * phoneNumberLT;
@property(nonatomic,readonly)UITextView * introduceTV;
@property(nonatomic,readonly)UIImageView * avatarImageView;

@end
