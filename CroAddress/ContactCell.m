//
//  ContactCell.m
//  CroAddress
//
//  Created by Departures on 04/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//

#import "ContactCell.h"
#import "ContactModel.h"
#import "ContactFrameModel.h"
@interface ContactCell()
//头像
@property (nonatomic,weak)UIImageView *iconImage;
//姓名
@property(nonatomic,weak)UILabel *nameString;
//电话号码
@property(nonatomic, weak)UILabel *telNum;


@end

@implementation ContactCell

+(instancetype)contactCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"contactCell";
    ContactCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        UIImageView *icon = [[UIImageView alloc]init];
        [self.contentView addSubview:icon];
        self.iconImage = icon;
        self.backgroundColor = [UIColor clearColor];
        
        //姓名
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:25.0f];
        nameLabel.textColor = [UIColor whiteColor];
        
        [self.contentView addSubview:nameLabel];
        self.nameString = nameLabel;
        
        //tel
        UILabel *telLabel = [[UILabel alloc]init];
        telLabel.textAlignment = NSTextAlignmentCenter;
        telLabel.font = [UIFont systemFontOfSize:20.0f];
        telLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:telLabel];
        self.telNum = telLabel;
    }
    return self;
}


-(void)setFrameModel:(ContactFrameModel *)frameModel{
    
    _frameModel = frameModel;
    
    ContactModel *model = frameModel.contact;
    
    //头像
    self.iconImage.image = [UIImage imageNamed:@"proFilePhoto.png"];
    
    //名字
    self.nameString.frame = frameModel.nameModelFrame;
    self.nameString.text = model.nameString;
    
    //telNum
    self.telNum.frame = frameModel.telModelFrame;
    self.telNum.text = model.telString;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
