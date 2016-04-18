//
//  EditContactViewController.m
//  ContactList
//
//  Created by  江苏 on 16/4/18.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "EditContactViewController.h"

@interface EditContactViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation EditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTF.text=self.contact.name;
    self.phoneTF.text=self.contact.phone;
   
}
- (IBAction)saveAction:(UIButton*)sender {
    
    self.contact.name=self.nameTF.text;
    self.contact.phone=self.phoneTF.text;
    if ([self.delegate respondsToSelector:@selector(SaveEditContactWithNewContactViewController:andContact:)]) {
        [self.delegate SaveEditContactWithNewContactViewController:self andContact:self.contact];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)editAction:(UIBarButtonItem *)sender {
    if ([self.editButton.title isEqualToString:@"编辑"]) {
        [self.editButton setTitle:@"取消"];
        self.nameTF.enabled=YES;
        self.phoneTF.enabled=YES;
        self.saveButton.enabled=YES;
        [self.phoneTF becomeFirstResponder];
        
    }else{
        [self.editButton setTitle:@"编辑"];
        self.nameTF.enabled=NO;
        self.phoneTF.enabled=NO;
        self.saveButton.enabled=NO;
        self.nameTF.text=self.contact.name;
        self.phoneTF.text=self.contact.phone;
    }
}



@end
