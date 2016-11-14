//
//  DetailViewController.m
//  CroAddress
//
//  Created by Departures on 14/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//

#import "DetailViewController.h"

#import "ContactFrameModel.h"
#import "ContactModel.h"
#import "ContactCell.h"
@interface DetailViewController ()

@property (nonatomic,strong) NSMutableArray *contactsMutableArray;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置毛玻璃效果
    [self setBackgroundImageBlur];
    [self.blurView addSubview:self.contentView];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    //移除下划线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置TableView
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableViewDidLoad{
    //清空背景颜色
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
-(void)setBackgroundImageBlur{
    //添加毛玻璃效果，所有的之后元素要加到blurView上
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurView = [[UIVisualEffectView alloc]initWithEffect:beffect];
    self.blurView.frame = self.view.bounds;
    [self.view addSubview:self.blurView];
}



-(BOOL)prefersStatusBarHidden{
    return YES;
}








/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


-(NSMutableArray *)contactsMutableArray{
    if (_contactsMutableArray == nil) {
        //        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"contacts.plist" ofType:nil]];
        
        NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[sandboxpath objectAtIndex:0] stringByAppendingPathComponent:@"result.plist"];
        NSLog(@"%@",NSHomeDirectory());
        //获取数据
        NSMutableDictionary *array = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSLog(@"%@",array);
        
        
        NSMutableArray *contactsArray =[NSMutableArray array];
        for (NSString *dict in array) {
            
            ContactModel *conta = [ContactModel contactWithDict:[array objectForKey:dict]];
            NSLog(@"testHead");
            NSLog(@"%@", dict);
            NSLog(@"test");
            
            ContactFrameModel *cf = [[ContactFrameModel alloc]init];
            cf.contact = conta;
            [contactsArray addObject:cf];
        }
        _contactsMutableArray = contactsArray;
    }
    return  _contactsMutableArray;
}

#pragma 获取数据方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactsMutableArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactFrameModel *model = self.contactsMutableArray[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCell *cell = [ContactCell contactCellWithTableView:tableView];
    ContactFrameModel *model = self.contactsMutableArray[indexPath.row];
    
    cell.frameModel = model;
    return cell;
}
@end
