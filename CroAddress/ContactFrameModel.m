//
//  ContactFrameModel.m
//  CroAddress
//
//  Created by Departures on 04/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//

#import "ContactFrameModel.h"
#import "ContactModel.h"
@implementation ContactFrameModel

-(void)setContact:(ContactModel *)contact{
    _contact = contact;
    
    CGFloat padding = 10;
    
    //头像
    CGFloat iconX = padding;
    CGFloat iconY = 0;
    CGFloat iconWidth = 50;
    CGFloat iconHeight = 50;
    
    _iconModelFrame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    
    //姓名
    
    
    CGFloat nameX = padding + iconWidth;
    CGFloat nameY = padding;
    _nameModelFrame = CGRectMake(nameX, nameY, 100, 22);
    
    //tel
    
    CGFloat telX = 200;
    CGFloat telY = 0;
    CGFloat telWidth = 200;
    CGFloat telHeight = 50;
    _telModelFrame = CGRectMake(telX, telY, telWidth, telHeight);
    
    //cell高度
    
    _cellHeight = 44;
    
}

@end
