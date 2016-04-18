//
//  EditContactViewController.h
//  ContactList
//
//  Created by  江苏 on 16/4/18.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
@class EditContactViewController;
@class Contact;

@protocol EditContactViewControllerDelegate <NSObject>

@optional

-(void)SaveEditContactWithNewContactViewController:(EditContactViewController*) editContactViewController andContact:(Contact*)contact;

@end
@interface EditContactViewController : UIViewController

@property(nonatomic,strong)Contact* contact;
@property(nonatomic,weak)id<EditContactViewControllerDelegate> delegate;

@end
