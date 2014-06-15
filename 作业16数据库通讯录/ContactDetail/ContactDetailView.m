//
//  ContactDetailView.m
//  AddressBook
//
//  Created by lanou3g on 14-6-10.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ContactDetailView.h"
#import "LTView.h"
@implementation ContactDetailView

- (void)dealloc
{
    RELEASE_SAFELY(_nameLT);
    RELEASE_SAFELY(_sexLT);
    RELEASE_SAFELY(_ageLT);
    RELEASE_SAFELY(_phoneNumberLT);
    RELEASE_SAFELY(_introduceTV);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews
{
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 100, 120)];
    _avatarImageView.backgroundColor = [UIColor yellowColor];
    _avatarImageView.userInteractionEnabled = YES;
    [self addSubview:_avatarImageView];
    // 110,15,120,30
    _nameLT = [[LTView alloc] initWithFrame:CGRectMake(110, 15+70, 180, 30)];
    _nameLT.labelLT.text = @"姓名";
//    _nameLT.backgroundColor = [UIColor greenColor];
    [self addSubview:_nameLT];
    
    //110  55  120 30
    _phoneNumberLT = [[LTView alloc] initWithFrame:CGRectMake(110, 55+70, 180, 30)];
    _phoneNumberLT.labelLT.text = @"电话";
    //_phoneNumberLT.backgroundColor = [UIColor redColor];
    [self addSubview:_phoneNumberLT];
    
    _ageLT = [[LTView alloc] initWithFrame:CGRectMake(110, 95+70, 180, 30)];
    _ageLT.labelLT.text = @"年龄";
//    _ageLT.backgroundColor = [UIColor greenColor];
    [self addSubview:_ageLT];
    
    _sexLT = [[LTView alloc] initWithFrame:CGRectMake(110, 135+70, 180, 30)];
    _sexLT.labelLT.text = @"性别";
//    _sexLT.textFielsLT.placeholder = @"性别";
//    _sexLT.backgroundColor = [UIColor greenColor];
    [self addSubview:_sexLT];
    
    UILabel * introuduceTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 175+70, 80, 30)];
    introuduceTitle.text = @"自我介绍";
    [self addSubview:introuduceTitle];
    [introuduceTitle release];
    
    _introduceTV = [[UITextView alloc] initWithFrame:CGRectMake(120, 175+70, 180, 200)];
    
    _introduceTV.backgroundColor = [UIColor cyanColor];

    _introduceTV.font = [UIFont systemFontOfSize:13.0];
    [self addSubview:_introduceTV];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
