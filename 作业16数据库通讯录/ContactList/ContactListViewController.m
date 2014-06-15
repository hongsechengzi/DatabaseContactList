
//
//  ContactListViewController.m
//  作业16数据库通讯录
//
//  Created by lanou3g on 14-6-13.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "ContactListViewController.h"
#import "ContactPerson.h"
#import "ContactDetailViewController.h"
#import "DataHandle.h"
#import "ContactCell.h"
#import "UpdateContactViewController.h"

@interface ContactListViewController ()
@property(nonatomic,retain)DataHandle * handle;
@end

@implementation ContactListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"所有联系人";
    UIBarButtonItem * addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didClickAddButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
   _handle = [DataHandle shareInstance];
    
}
#pragma mark---------添加联系人按钮响应------------
- (void)didClickAddButtonItemAction:(UIBarButtonItem *)buttonItem
{
    ContactDetailViewController * contactDetailVC = [[ContactDetailViewController alloc] init];
    
    [self.navigationController pushViewController:contactDetailVC animated:YES];
    [contactDetailVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
      return [_handle.allGroupNameArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_handle countOfOneGroupWithSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactPerson * person = [_handle contactPersonOfOneGroupWithIndexPath:indexPath];
    static NSString * identifier = @"cell";
    ContactCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[ContactCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    cell.nameLabel.text = person.name;
    cell.phoneNumberLabel.text = person.phoneNumber;
    cell.avatarImageView.image = person.avatarImage;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_handle groupNameWithSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
//重新加载数据
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSInteger count = [_handle countOfOneGroupWithSection:indexPath.section];
        if (count > 1) {
             [_handle deleteContactPersonOfDBWithIndexPath:indexPath];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }else{
            [_handle deleteContactPersonOfDBWithIndexPath:indexPath];
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section ] withRowAnimation:UITableViewRowAnimationRight];
        }
        NSLog(@"%@",_handle.allContactDic);
    }
}

//更新联系人信息
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactPerson * person = [_handle contactPersonOfOneGroupWithIndexPath:indexPath];
    UpdateContactViewController * updateVC = [[UpdateContactViewController alloc] init];
    updateVC.person = person;
    [self.navigationController pushViewController:updateVC animated:YES];
    [person release];
    [updateVC release];
}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
