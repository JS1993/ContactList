//
//  ContactsListViewController.m
//  ContactList
//
//  Created by  江苏 on 16/4/18.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ContactsListViewController.h"
#import "NewContactViewController.h"
#import "Contact.h"
#import "EditContactViewController.h"

#define  filePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"contactList.data"]
@interface ContactsListViewController ()<NewContactViewControllerDelegate,UIActionSheetDelegate,EditContactViewControllerDelegate>

@property(nonatomic,strong)NSMutableArray* ContactLists;
@property(nonatomic)int index;

@end

@implementation ContactsListViewController

-(NSMutableArray *)ContactLists{
    if (_ContactLists==nil) {
        
        _ContactLists=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if (_ContactLists==nil) {
            _ContactLists=[NSMutableArray array];
        }
    }
    return _ContactLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=[NSString stringWithFormat:@"%@的通讯录",self.titleText];
    
    //取消分割线(机制啊！)
    self.tableView.tableFooterView=[[UIView alloc]init];
}

//编辑按钮
- (IBAction)editButton:(UIBarButtonItem *)sender {
        //打开编辑状态
        [self.tableView setEditing:!self.tableView.editing animated:YES];
        if (self.tableView.editing) {
            //点击编辑之后变成完成
            sender.title=@"完成";
        }else{
            sender.title=@"编辑";
        }
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ContactLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Contact* con=self.ContactLists[indexPath.row];
    cell.textLabel.text=con.name;
    cell.detailTextLabel.text=con.phone;
    return cell;
}
#pragma mark-tableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Contact* con=self.ContactLists[indexPath.row];
     [self.ContactLists removeObjectAtIndex:indexPath.row];
     self.index=(int)indexPath.row;
    [self performSegueWithIdentifier:@"editContact" sender:con];
}

/**
 *  实现协议方法
 */
-(void)SaveContactWithNewContactViewController:(NewContactViewController*) newContactViewController andContact:(Contact*)contact{
    
    [self.ContactLists addObject:contact];
    
    
    [NSKeyedArchiver archiveRootObject:self.ContactLists toFile:filePath];
    
    [self.tableView reloadData];;
}

-(void)SaveEditContactWithNewContactViewController:(EditContactViewController*) editContactViewController andContact:(Contact*)contact{
    //插入到原来的行中
    [self.ContactLists insertObject:contact atIndex:self.index];

    [NSKeyedArchiver archiveRootObject:self.ContactLists toFile:filePath];
    
    [self.tableView reloadData];
}
/**
 *  设置代理
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"newContact"]) {
        NewContactViewController* new=segue.destinationViewController;
        new.delegate=self;
    }else if([segue.identifier isEqualToString:@"editContact"]){
        EditContactViewController* editVC=segue.destinationViewController;
        editVC.contact=sender;
        editVC.delegate=self;
    }
}

/**
 *  注销按钮的点击事件
 */
- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    UIActionSheet* action=[[UIActionSheet alloc]initWithTitle:@"您确定要退出登录吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [action showInView:self.view];
}

/**
 *  UIActionSheet的代理方法
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 *  新建联系人事件
 */
- (IBAction)newContact:(UIBarButtonItem*)sender {
    [self performSegueWithIdentifier:@"newContact" sender:nil];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.ContactLists removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [NSKeyedArchiver archiveRootObject:self.ContactLists toFile:filePath];
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
       
    }   
}


//移动联系人功能
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    Contact* con=self.ContactLists[fromIndexPath.row];
    
    [self.ContactLists removeObjectAtIndex:fromIndexPath.row];
    
    [self.ContactLists insertObject:con atIndex:toIndexPath.row];
    
    [NSKeyedArchiver archiveRootObject:self.ContactLists toFile:filePath];
    
    [self.tableView reloadData];
}

// 打开移动功能
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
