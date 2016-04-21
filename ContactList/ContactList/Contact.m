//
//  Contact.m
//  ContactList
//
//  Created by  江苏 on 16/4/18.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "Contact.h"

@implementation Contact


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_phone forKey:@"phone"];
    [aCoder encodeBool:_Hidden forKey:@"Hidden"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        _name=[aDecoder decodeObjectForKey:@"name"];
        _phone=[aDecoder decodeObjectForKey:@"phone"];
        _Hidden=[aDecoder decodeObjectForKey:@"Hidden"];
    }
    return self;
}

@end
