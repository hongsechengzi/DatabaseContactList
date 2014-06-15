//
//  LTView.m
//  AddressBook
//
//  Created by lanou3g on 14-6-10.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "LTView.h"

@implementation LTView
- (void)dealloc
{
    RELEASE_SAFELY(_labelLT);
    RELEASE_SAFELY(_textFielsLT);
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
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    _labelLT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width/3, height)];
    [self addSubview:_labelLT];
    
   _textFielsLT = [[UITextField alloc] initWithFrame:CGRectMake(width/3, 0, 2 * width/3, height)];
    _textFielsLT.borderStyle = UITextBorderStyleRoundedRect;
    _textFielsLT.delegate = self;
    [self addSubview:_textFielsLT];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textFielsLT resignFirstResponder];
    return YES;
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
