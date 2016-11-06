//
//  newContactViewController.m
//  CroAddress
//
//  Created by Departures on 04/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//

#import "newContactViewController.h"

@interface newContactViewController ()

@end

@implementation newContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImageBlur];
    [self setIconImageViewRound];
    [self.blurView addSubview:self.nameTextField.superview];
    //   self.iconImageView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3);
    self.iconImageView.bounds = CGRectMake(self.view.frame.size.width/2 - 44, self.iconImageView.frame.size.height/3 - 44, 88, 88 );

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBackgroundImageBlur{
    //添加毛玻璃效果，所有的之后元素要加到blurView上
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurView = [[UIVisualEffectView alloc]initWithEffect:beffect];
    self.blurView.frame = self.view.bounds;
    [self.view addSubview:self.blurView];
}

-(void)setIconImageViewRound{
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius =self.iconImageView.frame.size.width / 2 ;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue send
 er:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signUpButtonDidPress:(id)sender {
//    //获取文件路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *plistPath = [paths objectAtIndex:0];
//    NSString *filename=[plistPath stringByAppendingPathComponent:@"contacts.plist"];
////    NSMutableArray *test = [NSMutableArray array];
////    [test addObject:@"test"];
//    NSDictionary *test = [NSDictionary dictionaryWithObjectsAndKeys:@"aha",@"nameString",@"12345",@"telString" ,nil];
//    [test writeToFile:filename atomically:YES];

    
    
//    
//    NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//     //获取完整路径
//     NSString *documentsDirectory = [sandboxpath objectAtIndex:0];
//    
//    
//     NSString *plistPathName = [documentsDirectory stringByAppendingPathComponent:@"contactsByName.plist"];
//     //存储根数据
//     NSMutableDictionary *rootDicName = [[NSMutableDictionary alloc ] init];
//     //字典中的详细数据
//     NSMutableDictionary *userDataDic = [[NSMutableDictionary alloc]init];
//     [userDataDic setObject:self.nameTextField.text forKey:@"nameString"];
//     [userDataDic setObject:self.telTextField.text forKey:@"telString"];
//    //两种方式，只需要更改一下key就可以了
//    [rootDicName setObject:userDataDic forKey:self.nameTextField.text];
//     //写入文件
//     [rootDicName writeToFile:plistPathName atomically:NO];
//     NSLog(@"%@",NSHomeDirectory());
//    NSMutableDictionary *rootDicTel = [[NSMutableDictionary alloc ] init];
//
//    NSString *plistPathTel = [documentsDirectory stringByAppendingPathComponent:@"contactsByTel.plist"];
//    
//    [rootDicTel setObject:userDataDic forKey:self.telTextField.text];
//    [rootDicTel writeToFile:plistPathTel atomically:NO];
//    NSLog(@"写入成功");
    
    //获取沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // plist 路径
    NSString *plistPathForName = [documentsDirectory stringByAppendingPathComponent:@"contactsByName.plist"];
    NSString *plistPathForTel = [documentsDirectory stringByAppendingPathComponent:@"contactsByTel.plist"];
    
    NSFileManager *fileManager = [[NSFileManager  alloc]init];
    
    NSDictionary *contentDict = [NSDictionary dictionaryWithObjectsAndKeys:self.nameTextField.text ,@"nameString",self.telTextField.text,@"telString", nil];
    
    //hash姓名
    NSUInteger keyIntByName = [self hashWithInput:self.nameTextField.text];
    NSString *keyByName = [NSString stringWithFormat:@"%lu",keyIntByName];
    //hash电话号码
    NSUInteger keyIntByTel = [self hashWithInput:self.telTextField.text];
    NSString *keyByTel = [NSString stringWithFormat:@"%lu",keyIntByTel];
    //按照姓名作为hash写入用的Dic
        //按照Tel作为hash写入用的Dic
    //判断Name文件是否存在，不存在的话是否创建失败
    if (![fileManager fileExistsAtPath:plistPathForName]) {
        if (![fileManager createFileAtPath:plistPathForName contents:nil attributes:nil]) {
            NSLog(@"创建contactsByName文件出错");
        } else {
            //写入Nameplist
            NSDictionary *contactsDictByName = [NSDictionary dictionaryWithObjectsAndKeys:contentDict,keyByName, nil];
            [contactsDictByName writeToFile:plistPathForName atomically:YES];
            
            //写入TelPlist
            NSDictionary *contactsDictByTel = [NSDictionary dictionaryWithObject:contentDict forKey:keyByTel];
            [contactsDictByTel writeToFile:plistPathForTel atomically:YES];
            
        }
    } else {
        //写入Name文件，同时注意碰撞
        NSMutableDictionary *contactsDictByName = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPathForName];
        while ([[contactsDictByName allKeys]containsObject:keyByName]) {
            keyIntByName++;
            keyByName = [NSString stringWithFormat:@"%lu",keyIntByName];
        }
        [contactsDictByName setObject:contentDict forKey:keyByName];
        [contactsDictByName writeToFile:plistPathForName atomically:YES];
        
        //写入Tel文件，同时注意碰撞
        NSMutableDictionary *contactsDictByTel = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPathForTel];
        while ([[contactsDictByName allKeys]containsObject:keyByTel]) {
            keyIntByTel++;
            keyByTel = [NSString stringWithFormat:@"%lu",keyIntByTel];
        }
        [contactsDictByTel setObject:contentDict forKey:keyByTel];
        [contactsDictByTel writeToFile:plistPathForTel atomically:YES];

    }
    

    
    

}

-(NSUInteger)hashWithInput:(NSString *)inputString{
    NSUInteger result = [inputString hash];
    NSLog(@"hash之后的结果是%lu ", (unsigned long)result);
    return result;
}


- (IBAction)goBackButtonDidPress:(id)sender {
    [self performSegueWithIdentifier:@"NewGoBack" sender:self];
}


@end
