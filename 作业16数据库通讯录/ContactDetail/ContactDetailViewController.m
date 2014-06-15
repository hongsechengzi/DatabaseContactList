//
//  ContactDetailViewController.m
//  作业16数据库通讯录
//
//  Created by lanou3g on 14-6-13.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ContactDetailViewController.h"
#import "ContactDetailView.h"
#import "ContactPerson.h"
#import "LTView.h"
#import "DataHandle.h"
@interface ContactDetailViewController ()
@property(nonatomic,retain)ContactDetailView * contactDetailViwe;
@property(nonatomic,retain)ContactPerson * person;

@end

@implementation ContactDetailViewController
- (void)dealloc
{
    RELEASE_SAFELY(_contactDetailViwe);
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
    self.contactDetailViwe = [[[ContactDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _contactDetailViwe;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contactDetailViwe.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加联系人";
    UIBarButtonItem * finishButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didClickFinishButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = finishButtonItem;
    //给显示头像的imageView添加手势
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureForImageView:)];
    [_contactDetailViwe.avatarImageView addGestureRecognizer:tapGesture];
    [tapGesture release];
}
#pragma mark---------点击完成按钮------------
- (void)didClickFinishButtonItemAction:(UIBarButtonItem *)buttonItem
{
    if ([_contactDetailViwe.nameLT.textFielsLT.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"姓名不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }else{
    ContactPerson * person = [[ContactPerson alloc] init];
    person.avatarImage = _contactDetailViwe.avatarImageView.image;
    person.name = _contactDetailViwe.nameLT.textFielsLT.text;
    person.sex = _contactDetailViwe.sexLT.textFielsLT.text;
    person.age = _contactDetailViwe.ageLT.textFielsLT.text;
    person.phoneNumber = _contactDetailViwe.phoneNumberLT.textFielsLT.text;
    person.introduce = _contactDetailViwe.introduceTV.text;
    [[DataHandle shareInstance] insertNewContactPerson:person];
    [person release];
    [self.navigationController popViewControllerAnimated:YES];
    }
}
//相册手势
- (void)handleTapGestureForImageView:(UITapGestureRecognizer *)gesture
{
    UIImagePickerController * pickerNC = [[UIImagePickerController alloc] init];
    [pickerNC setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    pickerNC.delegate = self;
    [self presentViewController:pickerNC animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _contactDetailViwe.avatarImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
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
