//
//  ContactModel.h
//  CroAddress
//
//  Created by Departures on 04/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
//姓名
@property (nonatomic ,copy)NSString *nameString;
//电话号码
@property (nonatomic,copy)NSString *telString;
//头像
@property (nonatomic,copy)UIImage *iconImage;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)contactWithDict:(NSDictionary *)dict;


@end
