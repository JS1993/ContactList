//
//  Contact.h
//  ContactList
//
//  Created by  江苏 on 16/4/18.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject<NSCoding>

@property(copy,nonatomic)NSString* name;
@property(copy,nonatomic)NSString* phone;

@property(nonatomic,assign)BOOL Hidden;
@end
