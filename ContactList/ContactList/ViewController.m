//
//  ViewController.m
//  ContactList
//
//  Created by  江苏 on 16/4/18.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "ContactsListViewController.h"
#import "MBProgressHUD+XMG.h"

#define userDefaults [NSUserDefaults standardUserDefaults]

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *userKeyTF;
@property (strong, nonatomic) IBOutlet UISwitch *saveKey;
@property (strong, nonatomic) IBOutlet UISwitch *autoLogin;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

static NSString* userName=@"userName";
static NSString* userKey=@"userKey";
static NSString* autoLog=@"autoLogin";
static NSString* remK=@"remKey";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* account=[userDefaults objectForKey:userName];
    NSString* key=[userDefaults objectForKey:userKey];
    BOOL autoLogin=[userDefaults boolForKey:autoLog];
    BOOL remKey=[userDefaults boolForKey:remK];
    
    self.saveKey.on=remKey;
    self.autoLogin.on=autoLogin;
    
    if (remKey) {
        self.userNameTF.text=account;
        self.userKeyTF.text=key;
    }
    if (autoLogin) {
        [self login:nil];
    }
    [self.userNameTF addTarget:self action:@selector(checkCharacters) forControlEvents:UIControlEventEditingChanged];
    [self.userKeyTF addTarget:self action:@selector(checkCharacters) forControlEvents:UIControlEventEditingChanged];
    
    [self checkCharacters];
}

/**
 *  设置登录按钮状态
 */
-(void)checkCharacters{
    self.loginButton.enabled=self.userKeyTF.text.length&&self.userNameTF.text.length;
}

/**
 *登陆事件
 */
- (IBAction)login:(UIButton *)sender {
    
    [MBProgressHUD showMessage:@"正在登录..."];
    
    //多线程模拟登录
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        //判断用户名和密码匹配
        if ([self.userNameTF.text isEqualToString:@"jiangsu"]&&[self.userKeyTF.text isEqualToString:@"123"]) {
            
            [userDefaults setObject:self.userNameTF.text forKey:userName];
            [userDefaults setObject:self.userKeyTF.text forKey:userKey];
            [userDefaults setBool:self.saveKey.on forKey:remK];
            [userDefaults setBool:self.autoLogin.on forKey:autoLog];
            
            [self performSegueWithIdentifier:@"goToContactVc" sender:nil];
        }else{
            [MBProgressHUD showError:@"用户名或密码错误"];
        }
    });
    
}


/**
 *  执行跳转
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ContactsListViewController* vc=segue.destinationViewController;
    //正向传值
    vc.titleText=self.userNameTF.text;
}

/**
 *  记住密码选择器
 */
- (IBAction)saveKeySwitch:(UISwitch *)sender {
    //如果不记住密码，那么无法自动登录
    if (!self.saveKey.isOn) {
        [self.autoLogin setOn:NO animated:YES];
    }
}

/**
 *  自动登录选择器
 */
- (IBAction)autoLoginSwitch:(UISwitch *)sender {
    //如果自动登录，必须记住密码
    if (self.autoLogin.isOn) {
        [self.saveKey setOn:YES animated:YES];
    }
}
@end
