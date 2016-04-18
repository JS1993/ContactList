//
//  NewContactViewController.m
//  ContactList
//
//  Created by  江苏 on 16/4/18.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "NewContactViewController.h"
#import "Contact.h"

@interface NewContactViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation NewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nameTF becomeFirstResponder];
    
    [self.nameTF addTarget:self action:@selector(checkCharacters) forControlEvents:UIControlEventEditingChanged];
    [self.phoneTF addTarget:self action:@selector(checkCharacters) forControlEvents:UIControlEventEditingChanged];
    
    [self checkCharacters];
}

/**
 *  设置登录按钮状态
 */
-(void)checkCharacters{
    self.saveButton.enabled=self.nameTF.text.length&&self.phoneTF.text.length;
}



- (IBAction)saveAction:(UIButton *)sender {
    Contact* con=[[Contact alloc]init];
    con.name=self.nameTF.text;
    con.phone=self.phoneTF.text;
    
    if ([self.delegate respondsToSelector:@selector(SaveContactWithNewContactViewController:andContact:)]) {
        [self.delegate SaveContactWithNewContactViewController:self andContact:con];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    
}

@end
