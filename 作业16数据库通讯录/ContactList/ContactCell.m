//
//  ContactCell.m
//  作业16数据库通讯录
//
//  Created by lanou3g on 14-6-14.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ContactCell.h"
#import "ContactPerson.h"
@implementation ContactCell
- (void)dealloc
{
    RELEASE_SAFELY(_avatarImageView);
    RELEASE_SAFELY(_nameLabel);
    RELEASE_SAFELY(_phoneNumberLabel);
    RELEASE_SAFELY(_introduceLabel);
    RELEASE_SAFELY(_person);
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

//创建cell上自定义的子视图控件
- (void)setupSubviews
{
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 80)];
       _avatarImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_avatarImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, 120, 30)];
    _nameLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_nameLabel];
    
    _phoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 55, 120, 30)];
      _phoneNumberLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_phoneNumberLabel];
    
    _introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 105, 280, 20)];
    _introduceLabel.backgroundColor = [UIColor grayColor];
    _introduceLabel.numberOfLines = 0;
    _introduceLabel.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:_introduceLabel];
}
- (void)setPerson:(ContactPerson *)person
{
    if (_person != person) {
        [_person release];
        _person = [person retain];
    }
    _avatarImageView.image = person.avatarImage;
    _nameLabel.text = person.name;
    _phoneNumberLabel.text = person.phoneNumber;
    _introduceLabel.text = person.introduce;
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
