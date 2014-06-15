//
//  UpdateContactViewController.m
//  作业16数据库通讯录
//
//  Created by lanou3g on 14-6-15.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "UpdateContactViewController.h"
#import "ContactDetailView.h"
#import "LTView.h"
#import "ContactPerson.h"
#import "DataHandle.h"

@interface UpdateContactViewController ()
@property(nonatomic,retain)ContactDetailView * contactDetailView;
@end

@implementation UpdateContactViewController
- (void)dealloc
{
    RELEASE_SAFELY(_contactDetailView);
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView
{
    self.contactDetailView = [[[ContactDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _contactDetailView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contactDetailView.backgroundColor = [UIColor whiteColor];
     self.navigationItem.title = _person.name;
    [self uneditContactPersonInformation];
    self.contactDetailView.nameLT.textFielsLT.text = _person.name;
    self.contactDetailView.phoneNumberLT.textFielsLT.text = _person.phoneNumber;
    self.contactDetailView.sexLT.textFielsLT.text = _person.sex;
    self.contactDetailView.ageLT.textFielsLT.text = _person.age;
    self.contactDetailView.introduceTV.text = _person.introduce;
    self.contactDetailView.avatarImageView.image = _person.avatarImage;
    UIBarButtonItem * backBttonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didClickLeftButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backBttonItem;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem.title = @"编辑";
}

- (void)didClickLeftButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing == YES) {
        //编辑状态
    self.navigationItem.rightBarButtonItem.title = @"保存";
        [self caneditContactPersonInformation];
        NSLog(@"_person.name++++%@",_person.name);
    }else{
        //保存状态
    self.navigationItem.rightBarButtonItem.title = @"编辑";
        [self saveContactNewInformation];
        [self uneditContactPersonInformation];
          NSLog(@"_person.name------%@",_person.name);
        [[DataHandle shareInstance] updateContactPersonInformation:_person];
        NSLog(@"_person.name------%@",_person.name);
    }
}
- (void)saveContactNewInformation
{
    _person.name = _contactDetailView.nameLT.textFielsLT.text;
    _person.age = _contactDetailView.ageLT.textFielsLT.text;
    _person.sex = _contactDetailView.sexLT.textFielsLT.text;
    _person.phoneNumber = _contactDetailView.phoneNumberLT.textFielsLT.text;
    _person.introduce = _contactDetailView.introduceTV.text;
    _person.avatarImage = _contactDetailView.avatarImageView.image;
}
//可以编辑联系人信息
- (void)caneditContactPersonInformation
{
    self.contactDetailView.nameLT.userInteractionEnabled = YES;
    self.contactDetailView.ageLT.userInteractionEnabled = YES;
    self.contactDetailView.sexLT.userInteractionEnabled = YES;
    self.contactDetailView.phoneNumberLT.userInteractionEnabled = YES;
    self.contactDetailView.introduceTV.userInteractionEnabled = YES;
    self.contactDetailView.nameLT.textFielsLT.borderStyle = UITextBorderStyleRoundedRect;
    self.contactDetailView.phoneNumberLT.textFielsLT.borderStyle = UITextBorderStyleRoundedRect;
    self.contactDetailView.ageLT.textFielsLT.borderStyle = UITextBorderStyleRoundedRect;
    self.contactDetailView.sexLT.textFielsLT.borderStyle = UITextBorderStyleRoundedRect;
    self.contactDetailView.avatarImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureAction:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.contactDetailView.avatarImageView addGestureRecognizer:tapGesture];
    [tapGesture release];
}

//不能编辑联系人信息
- (void)uneditContactPersonInformation
{
    self.contactDetailView.nameLT.userInteractionEnabled = NO;
    self.contactDetailView.ageLT.userInteractionEnabled = NO;
    self.contactDetailView.sexLT.userInteractionEnabled = NO;
    self.contactDetailView.phoneNumberLT.userInteractionEnabled = NO;
    self.contactDetailView.introduceTV.userInteractionEnabled = NO;
    self.contactDetailView.nameLT.textFielsLT.borderStyle = UITextBorderStyleNone;
    self.contactDetailView.phoneNumberLT.textFielsLT.borderStyle = UITextBorderStyleNone;
    self.contactDetailView.ageLT.textFielsLT.borderStyle = UITextBorderStyleNone;
    self.contactDetailView.sexLT.textFielsLT.borderStyle = UITextBorderStyleNone;
     self.contactDetailView.avatarImageView.userInteractionEnabled = NO;
}
//选取照片手势
- (void)handleTapGestureAction:(UITapGestureRecognizer *)gesture
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
//获取照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _contactDetailView.avatarImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
