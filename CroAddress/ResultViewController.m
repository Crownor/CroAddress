//
//  ResultViewController.m
//  CroAddress
//
//  Created by Departures on 04/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [_blurView addSubview:self.resultView];
    [self.resultView setHidden:FALSE];
}
-(NSMutableDictionary *)getNameFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // plist 路径
    NSString *plistPathForName = [documentsDirectory stringByAppendingPathComponent:@"contactsByName.plist"];
    NSMutableDictionary *contactsDictByName = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPathForName];
    return contactsDictByName;
}

-(NSMutableDictionary *)getTelFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // plist 路径
    NSString *plistPathForTel = [documentsDirectory stringByAppendingPathComponent:@"contactsByTel.plist"];
    NSMutableDictionary *contactsDictByTel = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPathForTel];
    return contactsDictByTel;
}

-(NSArray *)getDictSorted:(NSMutableDictionary *)dict{
    NSArray *array = [dict allKeys];
    NSArray *resulyArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];}];
    NSLog(@"%@",resulyArray);
    return resulyArray;
    
}



- (IBAction)searchByNameButtonDidPress:(id)sender {
    NSMutableDictionary *resultDict =  [self getNameFile];
    NSMutableString *targetString = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%lu",[self.targetTextField.text hash]]];
    
    
    while ([[resultDict allKeys]containsObject:targetString]) {
        if ([[[resultDict objectForKey:targetString]objectForKey:@"nameString"] isEqualToString:self.targetTextField.text]) {
            [self setBackgroundImageBlur];
            self.nameTextField.text = self.targetTextField.text;
            self.telTextField.text = [[resultDict objectForKey:targetString]objectForKey:@"telString"];
            NSLog(@"%@", self.nameTextField.text);
            NSLog(@"%@", self.telTextField.text);
        }
       double targetNum = [targetString doubleValue];

        [targetString setString:[NSString stringWithFormat:@"%lu",(unsigned long)(targetNum+1)]];
    }
    
}
- (IBAction)searchByTelButtonDidPress:(id)sender {
    NSMutableDictionary *resultDict =  [self getTelFile];
    NSMutableString *targetString = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%lu",[self.targetTextField.text hash]]];
    
    
    while ([[resultDict allKeys]containsObject:targetString]) {
        if ([[[resultDict objectForKey:targetString]objectForKey:@"telString"] isEqualToString:self.targetTextField.text]) {
            [self setBackgroundImageBlur];
            self.telTextField.text = self.targetTextField.text;
            self.nameTextField.text = [[resultDict objectForKey:targetString]objectForKey:@"nameString"];
            NSLog(@"%@", self.nameTextField.text);
            NSLog(@"%@", self.telTextField.text);
        }
        double targetNum = [targetString doubleValue];
        
        [targetString setString:[NSString stringWithFormat:@"%lu",(unsigned long)(targetNum+1)]];
    }
}

-(void)removeBackgroundImageBlur{
    
    UIViewPropertyAnimator *animation = [[UIViewPropertyAnimator alloc]initWithDuration:1.5 curve:UIViewAnimationCurveEaseInOut animations:^{
        //把透明度提高，最后完全透明，然后删掉
        self.blurView.alpha = 0;
    }];
    [animation startAnimation];
    
    
    //    //一行代码删除掉所有的subview挺有意思的，可惜在这里用不上
    //    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
}

- (IBAction)goBackButtonDidPress:(id)sender {
    [self removeBackgroundImageBlur];
    [self performSegueWithIdentifier:@"searchToMain" sender:self];
}

- (IBAction)alterButtonDidPress:(id)sender {
    NSString *filepathName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"contactsByName.plist"];
    NSString *filepathTel = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"contactsByTel.plist"];
    //所有的数据列表
    NSMutableDictionary *datalistName= [[[NSMutableDictionary alloc]initWithContentsOfFile:filepathName]mutableCopy];
    NSMutableDictionary *datalistTel= [[[NSMutableDictionary alloc]initWithContentsOfFile:filepathName]mutableCopy];
    
    
    
    
    NSMutableDictionary *rootDicName = [[NSMutableDictionary alloc ] init];
    NSMutableDictionary *rootDicTel = [[NSMutableDictionary alloc ] init];

    //字典中的详细数据
    NSMutableDictionary *userDataDic = [[NSMutableDictionary alloc]init];
    [userDataDic setObject:self.nameTextField.text forKey:@"nameString"];
    [userDataDic setObject:self.telTextField.text forKey:@"telString"];
    //两种方式，只需要更改一下key就可以了
    [rootDicName setObject:userDataDic forKey:self.nameTextField.text];
    [rootDicTel setObject:userDataDic forKey:self.telTextField.text];
    
    [rootDicName writeToFile:filepathName atomically:YES];
    [rootDicTel writeToFile:filepathTel atomically:YES];

   
    }

- (IBAction)backButtonDidpress:(id)sender {
    [self removeBackgroundImageBlur];
    [self performSegueWithIdentifier:@"searchToMain" sender:self];

}
@end
