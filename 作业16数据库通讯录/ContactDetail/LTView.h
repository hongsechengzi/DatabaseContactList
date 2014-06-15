//
//  LTView.h
//  AddressBook
//
//  Created by lanou3g on 14-6-10.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTView : UIView<UITextFieldDelegate>

@property(nonatomic,readonly)UILabel * labelLT;
@property(nonatomic,retain)UITextField * textFielsLT;

@end
