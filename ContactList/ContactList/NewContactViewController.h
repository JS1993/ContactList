//
//  NewContactViewController.h
//  ContactList
//
//  Created by  江苏 on 16/4/18.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewContactViewController;
@class Contact;

@protocol NewContactViewControllerDelegate <NSObject>

@optional

-(void)SaveContactWithNewContactViewController:(NewContactViewController*) newContactViewController andContact:(Contact*)contact;

@end

@interface NewContactViewController : UIViewController

@property(nonatomic,weak)id<NewContactViewControllerDelegate> delegate;
@end
