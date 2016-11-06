//
//  ContactCell.h
//  CroAddress
//
//  Created by Departures on 04/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//
@class ContactFrameModel;
#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell

+(instancetype)contactCellWithTableView:(UITableView *) tableView;

//frame模型
@property(nonatomic ,strong) ContactFrameModel *frameModel;
@end
