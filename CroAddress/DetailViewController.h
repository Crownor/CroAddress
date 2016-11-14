//
//  DetailViewController.h
//  CroAddress
//
//  Created by Departures on 14/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *contentView;

//毛玻璃效果界面
@property  UIVisualEffectView *blurView;

//内容界面
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
