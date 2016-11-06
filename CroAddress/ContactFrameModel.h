//
//  ContactFrameModel.h
//  CroAddress
//
//  Created by Departures on 04/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class ContactModel;
@interface ContactFrameModel : NSObject

//头像的model
@property (nonatomic,assign,readonly)CGRect iconModelFrame;
//名字的model
@property(nonatomic ,assign,readonly)CGRect nameModelFrame;
//联系方式的Model
@property(nonatomic ,assign,readonly)CGRect telModelFrame;
//Cell高度
@property(nonatomic ,assign ,readonly)CGFloat cellHeight;
//数据模型
@property(nonatomic ,strong)ContactModel *contact;

@end
